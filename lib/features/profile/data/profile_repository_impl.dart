import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../../common/data/interest_model.dart';
import '../../common/data/skill_model.dart';
import '../../common/data/wish_model.dart';
import '../domain/profile_model.dart';
import '../domain/profile_repository.dart';

class ProfileRepositoryImpl extends ProfileRepository {
  final _firestore = FirebaseFirestore.instance;

  @override
  Future<void> saveProfile(ProfileModel profile) async {
    await _firestore
        .collection('profiles')
        .doc(profile.uid)
        .set(profile.toMap());
  }

  @override
  Future<ProfileModel?> getProfile(String uid) async {
    final doc = await _firestore.collection('profiles').doc(uid).get();

    if (doc.exists) {
      return ProfileModel.fromMap(doc.data()!);
    }
    return null;
  }

  /// Get stream of the interests from all profiles
  @override
  Stream<List<InterestModel>> getInterestsStream(
    List<InterestType> interestTypes,
  ) {
    final controller = StreamController<List<InterestModel>>();

    final subscription = _firestore.collection('profiles').snapshots().listen((
      snapshot,
    ) {
      final List<InterestModel> allInterests = [];

      for (var doc in snapshot.docs) {
        String uid = doc.data()['uid'];
        String userName = doc.data()['name'];

        List<dynamic> profileSkillsList =
            interestTypes.contains(InterestType.skill)
                ? doc.data()['skills']
                : [];
        List<dynamic> profileWishesList =
            interestTypes.contains(InterestType.wish)
                ? doc.data()['wishes']
                : [];
        for (var skillInAProfile in profileSkillsList) {
          allInterests.add(
            SkillModel(title: skillInAProfile, uid: uid, userName: userName),
          );
        }
        for (var wishInAProfile in profileWishesList) {
          allInterests.add(
            WishModel(title: wishInAProfile, uid: uid, userName: userName),
          );
        }
      }
      controller.add(allInterests);
    });

    controller.onCancel = () {
      subscription.cancel();
    };
    controller.onListen = () {
      subscription.resume();
    };

    return controller.stream;
  }
}
