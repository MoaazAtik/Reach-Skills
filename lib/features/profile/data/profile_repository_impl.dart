import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../core/constants/strings.dart';
import '../../common/data/interest_model.dart';
import '../../common/data/skill_model.dart';
import '../../common/data/wish_model.dart';
import '../domain/profile_model.dart';
import '../domain/profile_repository.dart';

class ProfileRepositoryImpl extends ProfileRepository {
  final _firestore = FirebaseFirestore.instance;

  int _interestsSubscriptionCount = 0;
  StreamSubscription<QuerySnapshot<Map<String, dynamic>>>?
  _interestsSubscription;
  final StreamController<List<InterestModel>> _interestsController =
      StreamController<List<InterestModel>>.broadcast();
  Stream<List<InterestModel>>? _interestsStream;

  /// Get stream of the interests from all profiles
  @override
  Stream<List<InterestModel>>? get interestsStream => _interestsStream;

  StreamSubscription<DocumentSnapshot<Map<String, dynamic>>>?
  _profileSubscription;
  final StreamController<ProfileModel> _profileController =
      StreamController<ProfileModel>();
  Stream<ProfileModel>? _profileStream;

  @override
  Stream<ProfileModel>? get profileStream => _profileStream;

  /// Profile always exists thus could be updated
  /// because of `_createProfileIfNeeded` and `subscribeToProfileStream`
  @override
  Future<String> updateProfile(ProfileModel profile) async {
    String result = '';

    await _firestore
        .collection(Str.PROFILE_COLLECTION_NAME)
        .doc(profile.uid)
        .update(profile.toMap())
        .onError((error, stackTrace) {
          print('error saving profile: $error');
          result = Str.errorSavingProfile;
        })
        .then((value) => result = Str.profileSaved);

    return result;
  }

  Future<String> _createProfileIfNeeded(ProfileModel profile) async {
    String result = '';

    final docRef = _firestore
        .collection(Str.PROFILE_COLLECTION_NAME)
        .doc(profile.uid);
    final docSnapshot = await docRef.get();

    if (docSnapshot.exists) return result;

    await docRef
        .set(profile.toMap())
        .onError((error, stackTrace) {
          print('error creating profile: $error');
          result = Str.errorSavingProfile;
        })
        .then((value) => result = Str.profileSaved);

    return result;
  }

  @override
  Future<String> removeInterest(InterestModel interest) {
    String result = '';

    _firestore
        .collection(Str.PROFILE_COLLECTION_NAME)
        .doc(interest.userId)
        .update({
          Str.PROFILE_FIELD_INTERESTS: FieldValue.arrayRemove([
            interest.toMap(),
          ]),
        })
        .onError((error, stackTrace) {
          print('error saving profile: $error');
          result = Str.errorSavingProfile;
        })
        .then((value) => result = Str.profileSaved);

    return Future.value(result);
  }

  @override
  Future<String> updateProfileTimestamp(String uid) {
    return _firestore
        .collection(Str.PROFILE_COLLECTION_NAME)
        .doc(uid)
        .update({
          Str.PROFILE_FIELD_LAST_EDITED_TIME:
              DateTime.now().millisecondsSinceEpoch,
        })
        .then((value) => Str.profileSaved)
        .onError((error, stackTrace) {
          print('Error updating profile timestamp: $error');
          return Str.errorSavingProfile;
        });
  }

  /// Subscribe to stream of the profile of the logged current user
  @override
  void subscribeToProfileStream({
    required String uid,
    required String email,
  }) async {
    _profileSubscription?.cancel();
    _profileStream = _profileController.stream;

    await _createProfileIfNeeded(
      ProfileModel(
        uid: uid,
        email: email,
        lastEditedTime: DateTime.now().millisecondsSinceEpoch,
      ),
    );

    _profileSubscription = _firestore
        .collection(Str.PROFILE_COLLECTION_NAME)
        .doc(uid)
        .snapshots()
        .listen(
          (snapshot) {
            /* snapshot.data() is always not null because `_createProfileIfNeeded`
             is called before it unless `_createProfileIfNeeded` throws an error. */
            if (snapshot.data() == null) return;
            _profileController.sink.add(ProfileModel.fromMap(snapshot.data()!));
          },
          onError: (errorObject, stackTrace) {
            _profileController.addError(errorObject);
          },
        );

    _profileController.onCancel = (() {
      _profileSubscription?.cancel();
    });
  }

  @override
  void unsubscribeFromProfileStream() {
    _profileController.close();
    _profileSubscription?.cancel();
  }

  /// Get profile of the logged current user.
  /// Note: Needed to update interests from `Explore Screen`.
  /// Check `ProfileViewModel.updateProfile`.
  @override
  Future<ProfileModel?> getProfile(String uid) async {
    final doc =
    await _firestore
        .collection(Str.PROFILE_COLLECTION_NAME)
        .doc(uid)
        .get();

    if (doc.exists) {
      return ProfileModel.fromMap(doc.data()!);
    }
    return null;
  }

  /// Get stream of the interests from all profiles
  @override
  void subscribeToInterestsStream({
    List<InterestType> interestTypes = InterestType.values,
  }) {
    _interestsSubscriptionCount++;

    if (_interestsSubscriptionCount <= 1) {
      _interestsStream = _interestsController.stream;

      _interestsSubscription = _firestore
          .collection(Str.PROFILE_COLLECTION_NAME)
          .snapshots()
          .listen(
            (snapshot) {
              final List<InterestModel> tempInterests = [];

              for (var doc in snapshot.docs) {
                // doc.data() is a profile map

                final List<dynamic>? interestsList =
                    doc.data()[Str.PROFILE_FIELD_INTERESTS];

                if (interestsList == null) {
                  continue;
                }

                for (final Map<String, dynamic> interestInAProfile in interestsList) {
                  // Check if the interest type that is stored as
                  // `InterestType.name` (* not InterestType) is in the wanted
                  // filter list of `interest types`
                  bool passesFilter = false;
                  for (final InterestType interestType in interestTypes) {
                    if (interestType.name == interestInAProfile[Str.INTEREST_FIELD_INTEREST_TYPE]) {
                      passesFilter = true;
                      break;
                    }
                  }
                  if (!passesFilter)  continue;

                  if (interestInAProfile[Str.INTEREST_FIELD_INTEREST_TYPE] ==
                      InterestType.skill.name) {
                    tempInterests.add(SkillModel.fromMap(interestInAProfile));
                  } else {
                    tempInterests.add(WishModel.fromMap(interestInAProfile));
                  }
                }
              }
              _interestsController.sink.add(tempInterests);
            },
            onError: (errorObject, stackTrace) {
              _interestsController.addError(errorObject);
            },
          );
    }

    _interestsController.onCancel = (() {
      _interestsSubscription?.cancel();
    });
  }

  @override
  void unsubscribeFromInterestsStream() {
    _interestsSubscriptionCount--;
    if (_interestsSubscriptionCount < 1) {
      _interestsController.close();
      _interestsSubscription?.cancel();
    }
  }
}
