import 'package:firebase_auth/firebase_auth.dart';

import '../domain/home_repository.dart';

class HomeRepositoryImpl extends HomeRepository {
  @override
  User? getCurrentUser() {
    return FirebaseAuth.instance.currentUser;
  }

  @override
  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }
}
