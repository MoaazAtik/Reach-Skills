import '../domain/profile_model.dart';
import '../domain/profile_repository.dart';

class ProfileViewModel {
  ProfileViewModel({required ProfileRepository profileRepository})
    : _profileRepository = profileRepository;

  final ProfileRepository _profileRepository;

  Future<void> saveProfile(ProfileModel profile) async {
    await _profileRepository.saveUserProfile(profile);
  }

  Future<ProfileModel?> getProfile(String uid) async {
    return await _profileRepository.getUserProfile(uid);
  }
}
