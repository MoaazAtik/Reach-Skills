import '../domain/models/app_user.dart';
import '../domain/profile_repository.dart';

class ProfileViewModel {
  ProfileViewModel({required ProfileRepository profileRepository})
    : _profileRepository = profileRepository;

  final ProfileRepository _profileRepository;

  Future<void> saveProfile(AppUser user) async {
    await _profileRepository.saveUserProfile(user);
  }

  Future<AppUser?> getProfile(String uid) async {
    return await _profileRepository.getUserProfile(uid);
  }
}
