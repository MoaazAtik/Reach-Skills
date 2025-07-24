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

  @override
  Future<String> saveProfile(ProfileModel profile) async {
    String result = '';
    final doc =
        await _firestore
            .collection(Str.PROFILE_COLLECTION_NAME)
            .doc(profile.uid)
            .get();

    if (doc.exists) {
      await _firestore
          .collection(Str.PROFILE_COLLECTION_NAME)
          .doc(profile.uid)
          .update(profile.toMap())
          .onError((error, stackTrace) {
            print('error saving profile: $error');
            result = Str.errorSavingProfile;
          })
          .then((value) => result = Str.profileSaved);
    } else {
      result = await _createProfile(profile);
    }

    return result;
  }

  Future<String> _createProfile(ProfileModel profile) async {
    String result = '';
    await _firestore
        .collection(Str.PROFILE_COLLECTION_NAME)
        .doc(profile.uid)
        .set(profile.toMap())
        .onError((error, stackTrace) {
          print('error creating profile: $error');
          result = Str.errorSavingProfile;
        })
        .then((value) => result = Str.profileSaved);

    return result;
  }

  @override
  Future<ProfileModel?> getProfile(String uid) async {
    final doc =
        await _firestore.collection(Str.PROFILE_COLLECTION_NAME).doc(uid).get();

    if (doc.exists) {
      return ProfileModel.fromMap(doc.data()!);
    }
    return null;
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
      Str.PROFILE_FIELD_LAST_EDITED_TIME: DateTime.now().millisecondsSinceEpoch,
    })
        .then((value) => Str.profileSaved)
        .onError((error, stackTrace) {
      print('Error updating profile timestamp: $error');
      return Str.errorSavingProfile;
    });
  }

  /// Subscribe to stream of the profile of the logged current user
  @override
  void subscribeToProfileStream({required String uid}) {
    _profileSubscription?.cancel();
    _profileStream = _profileController.stream;

    _profileSubscription = _firestore
        .collection(Str.PROFILE_COLLECTION_NAME)
        .doc(uid)
        .snapshots()
        .listen(
          (snapshot) {
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

                for (var interestInAProfile in interestsList) {
                  if (!interestTypes.contains(
                    interestInAProfile[Str.INTEREST_FIELD_INTEREST_TYPE],
                  )) {
                    continue;
                  }

                  if (interestInAProfile[Str.INTEREST_FIELD_INTEREST_TYPE] ==
                      InterestType.skill) {
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
