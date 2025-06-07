import '../data/profile_repository.dart';
import '../domain/models/app_user.dart';

class EditProfileViewModel {
  EditProfileViewModel({required ProfileRepository profileRepository})
    : _profileRepository = profileRepository;

  final ProfileRepository _profileRepository;

  Future<void> saveProfile(AppUser user) async {
    await _profileRepository.saveUserProfile(user);
  }

  Future<AppUser?> getProfile(String uid) async {
    return await _profileRepository.getUserProfile(uid);
  }
}
