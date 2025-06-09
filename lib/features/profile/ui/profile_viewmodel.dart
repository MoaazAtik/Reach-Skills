import 'package:flutter/foundation.dart';

import '../domain/profile_model.dart';
import '../domain/profile_repository.dart';

class ProfileViewModel extends ChangeNotifier {
  ProfileViewModel({required ProfileRepository profileRepository})
    : _profileRepository = profileRepository;

  final ProfileRepository _profileRepository;

  bool loading = true;
  ProfileModel? profile;
  bool edited = false;

  /* When calling this method from the profile screen,
   The passed uid is from the auth repository aka, Firebase auth,
   not the profile repository which is a Firestore collection.
   But, when calling this method within this class pass profile!.ui
   because profile is already loaded.*/
  Future<void> loadProfile(String? uid) async {
    if (uid != null) {
      profile = await _profileRepository.getProfile(uid);
      loading = false;
      notifyListeners();
    }
  }

  Future<String> updateProfile(ProfileModel newProfile) async {
    for (final entry in newProfile.toMap().entries) {
      // skip uid, email, lastEditedTime
      if (entry.key == 'uid' ||
          entry.key == 'email' ||
          entry.key == 'lastEditedTime') {
        continue;
      }

      // check skills
      if (entry.key == 'skills') {
        if (entry.value.toString() != profile!.toMap()[entry.key].toString()) {
          edited = true;
          break;
        }
        continue;
      }

      // check wishes
      if (entry.key == 'wishes') {
        if (entry.value.toString() != profile!.toMap()[entry.key].toString()) {
          edited = true;
          break;
        }
        continue;
      }

      // check name, bio
      if (entry.value != profile!.toMap()[entry.key]) {
        edited = true;
        break;
      }
    }

    if (!edited) return 'No changes to save';

    await _profileRepository.saveProfile(newProfile);
    loadProfile(profile!.uid);
    edited = false; // reset edited flag

    return 'Profile Saved';
  }
}
