import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';

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

  @override
  Future<void> saveProfile(ProfileModel profile) async {
    await _firestore
        .collection('profiles')
        .doc(profile.uid)
        .set(profile.toMap());
  }

  @override
  Future<ProfileModel?> getProfile(String uid) async {
    final doc =
        await _firestore
            .collection(ProfileModel.COLLECTION_NAME)
            .doc(uid)
            .get();

    if (doc.exists) {
      return ProfileModel.fromMap(doc.data()!);
    }
    return null;
  }

  @override
  void subscribeToInterestsStream({
    List<InterestType> interestTypes = InterestType.values,
  }) {
    _interestsSubscriptionCount++;

    if (_interestsSubscriptionCount <= 1) {
      _interestsStream = _interestsController.stream;

      _interestsSubscription = _firestore
          .collection(ProfileModel.COLLECTION_NAME)
          .snapshots()
          .listen(
            (snapshot) {
              final List<InterestModel> tempInterests = [];

              for (var doc in snapshot.docs) {
                String uid = doc.data()[ProfileModel.FIELD_UID];
                String userName = doc.data()[ProfileModel.FIELD_NAME];

                List<dynamic> profileSkillsList =
                    interestTypes.contains(InterestType.skill)
                        ? doc.data()[ProfileModel.FIELD_SKILLS]
                        : [];
                List<dynamic> profileWishesList =
                    interestTypes.contains(InterestType.wish)
                        ? doc.data()[ProfileModel.FIELD_WISHES]
                        : [];
                for (var skillInAProfile in profileSkillsList) {
                  tempInterests.add(
                    SkillModel(
                      title: skillInAProfile,
                      uid: uid,
                      userName: userName,
                    ),
                  );
                }
                for (var wishInAProfile in profileWishesList) {
                  tempInterests.add(
                    WishModel(
                      title: wishInAProfile,
                      uid: uid,
                      userName: userName,
                    ),
                  );
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
