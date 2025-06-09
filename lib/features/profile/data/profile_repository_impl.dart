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

  /// get the interests from all profiles
  @override
  Future<List<InterestModel>> getInterests(
    List<InterestType> interestTypes,
  ) async {
    List<InterestModel> allInterests = [];
    await _firestore.collection('profiles').get().then((querySnapshot) {
      for (var doc in querySnapshot.docs) {
        String uid = doc.data()['uid'];

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
            SkillModel(uid: uid, title: skillInAProfile),
          );
        }
        for (var wishInAProfile in profileWishesList) {
          allInterests.add(
            WishModel(uid: uid, title: wishInAProfile),
          );
        }

      }
    });
    return allInterests;
  }
}
