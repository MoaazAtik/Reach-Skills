import 'package:cloud_firestore/cloud_firestore.dart';

import '../domain/profile_model.dart';
import '../domain/profile_repository.dart';

class ProfileRepositoryImpl extends ProfileRepository {

  final _firestore = FirebaseFirestore.instance;

  @override
  Future<void> saveUserProfile(ProfileModel profile) async {
    await _firestore
        .collection('users')
        .doc(profile.uid)
        .set(profile.toMap());
  }

  @override
  Future<ProfileModel?> getUserProfile(String uid) async {
    final doc = await _firestore
        .collection('users')
        .doc(uid)
        .get();

    if (doc.exists) {
      return ProfileModel.fromMap(doc.data()!);
    }
    return null;
  }

}