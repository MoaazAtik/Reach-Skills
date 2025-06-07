import 'models/app_user.dart';

abstract class ProfileRepository {
  Future<void> saveUserProfile(AppUser user);

  Future<AppUser?> getUserProfile(String uid);
}
