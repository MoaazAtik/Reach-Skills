import 'profile_model.dart';

abstract class ProfileRepository {
  Future<void> saveProfile(ProfileModel profile);

  Future<ProfileModel?> getProfile(String uid);
}
