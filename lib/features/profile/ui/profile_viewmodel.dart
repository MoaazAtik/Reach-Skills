import 'dart:async';
import 'dart:math';

import 'package:flutter/foundation.dart';

import '../../../core/constants/strings.dart';
import '../../auth/domain/auth_repository.dart';
import '../../common/data/interest_model.dart';
import '../domain/profile_model.dart';
import '../domain/profile_repository.dart';

class ProfileViewModel extends ChangeNotifier {
  ProfileViewModel({
    required AuthRepository authRepository,
    required ProfileRepository profileRepository,
  }) : _authRepository = authRepository,
       _profileRepository = profileRepository {
    init();
  }

  final AuthRepository _authRepository;
  final ProfileRepository _profileRepository;

  bool loading = true;
  bool isEditing = false;
  String? uid;
  String? email;
  ProfileModel? profile;

  List<InterestModel> interests = [];
  StreamSubscription<ProfileModel>? _profileSubscription;
  String? profileStreamError;

  void init() {
    // startInterestsSubscription();
  }

  /* When calling this method from the profile screen,
   The passed uid is from the auth repository aka, Firebase auth,
   not the profile repository which is a Firestore collection.
   But, when calling this method within this class pass profile!.ui
   because profile is already loaded.*/
  // Todo perhaps remove this method because there is already
  //  `startInterestsSubscription()` instead.
  Future<void> loadProfile() async {
    uid = _authRepository.getUserId();
    email = _authRepository.getUserEmail();
    if (uid != null) {
      profile = await _profileRepository.getProfile(uid!);
      if (profile != null) {
        interests = [];
        interests.addAll(profile!.interests);
        interests.shuffle(Random());
      }
      startProfileSubscription();
      loading = false;
      notifyListeners();
    }
  }

  void startProfileSubscription() {
    if (uid == null) return;

    if (_profileSubscription != null) return;

    _profileRepository.subscribeToProfileStream(uid: uid!);

    _profileSubscription = _profileRepository.profileStream!.listen(
      (profile) {
        this.profile = profile;

        interests = [];
        interests.addAll(profile.interests);
        // interests.shuffle(Random());

        profileStreamError = null;
        loading = false;
        notifyListeners();
      },
      onError: (errorObject, stackTrace) {
        profileStreamError = Str.serverErrorMessage;
        loading = false;
        notifyListeners();
      },
    );
  }

  void stopSubscriptions() {
    _profileRepository.unsubscribeFromProfileStream();
    _profileSubscription?.cancel();
  }

  void toggleEdit() {
    isEditing = !isEditing;
    notifyListeners();
  }

  Future<String> updateProfile(ProfileModel newProfile) async {
    bool edited;
    if (profile == null) {
      // creating new profile
      edited = true;
    } else {
      edited = validateProfileUpdates(newProfile);
    }

    if (!edited) return Str.noChanges;

    await _profileRepository.saveProfile(newProfile);
    loadProfile();

    return Str.profileSaved;
  }

  bool validateProfileUpdates(ProfileModel newProfile) {
    bool edited = false;
    final profileMap = profile!.toMap();

    for (final entry in newProfile.toMap().entries) {
      // skip uid, email, lastEditedTime
      if (entry.key == Str.PROFILE_FIELD_UID ||
          entry.key == Str.PROFILE_FIELD_EMAIL ||
          entry.key == Str.PROFILE_FIELD_LAST_EDITED_TIME) {
        continue;
      }

      // check interests
      if (entry.key == Str.PROFILE_FIELD_INTERESTS) {
        if ((profile!.interests.isEmpty && newProfile.interests.isNotEmpty) ||
            newProfile.interests.length != profile!.interests.length) {
          edited = true;
          break;
        }
        for (final newInterest in newProfile.interests) {
          if (!profile!.interests.contains(newInterest)) {
            edited = true;
            break;
          }
        }
        if (edited) break;

        continue;
      }

      // check name, bio
      if (entry.value != profileMap[entry.key]) {
        edited = true;
        break;
      }
    }

    return edited;
  }

  @override
  void dispose() {
    stopSubscriptions();
    super.dispose();
  }
}
