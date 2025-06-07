import 'package:firebase_auth/firebase_auth.dart';

abstract class HomeRepository {
  User? getCurrentUser();

  Future<void> signOut();
}
