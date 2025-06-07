import 'package:cloud_firestore/cloud_firestore.dart';

import '../domain/models/app_user.dart';
import '../domain/profile_repository.dart';

class ProfileRepositoryImpl extends ProfileRepository {

  final _firestore = FirebaseFirestore.instance;

  @override
  Future<void> saveUserProfile(AppUser user) async {
    await _firestore
        .collection('users')
        .doc(user.uid)
        .set(user.toMap());
  }

  @override
  Future<AppUser?> getUserProfile(String uid) async {
    final doc = await _firestore
        .collection('users')
        .doc(uid)
        .get();

    if (doc.exists) {
      return AppUser.fromMap(doc.data()!);
    }
    return null;
  }

}