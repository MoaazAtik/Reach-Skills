import 'package:cloud_firestore/cloud_firestore.dart';

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
    final doc = await _firestore
        .collection('profiles')
        .doc(uid)
        .get();

    if (doc.exists) {
      return ProfileModel.fromMap(doc.data()!);
    }
    return null;
  }

  /// get the skills from all profiles
  @override
  Future<Set<String>> getSkills() async {
    Set<String> allSkills = {};

    await _firestore.collection('profiles').get().then((querySnapshot) {
      for (var doc in querySnapshot.docs) {
        List<dynamic> profileSkillsList = doc.data()['skills'];
        for (var skillInAProfile in profileSkillsList) {
          allSkills.add(skillInAProfile);
        }
      }
    });
    return allSkills;
  }
}