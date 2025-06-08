import 'profile_model.dart';

abstract class ProfileRepository {
  Future<void> saveUserProfile(ProfileModel profile);

  Future<ProfileModel?> getUserProfile(String uid);
}
