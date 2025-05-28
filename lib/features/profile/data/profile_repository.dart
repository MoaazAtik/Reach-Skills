import 'package:cloud_firestore/cloud_firestore.dart';

import '../domain/models/app_user.dart';

class ProfileRepository {

  final _firestore = FirebaseFirestore.instance;

  Future<void> saveUserProfile(AppUser user) async {
    await _firestore
        .collection('users')
        .doc(user.uid)
        .set(user.toMap());
  }

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