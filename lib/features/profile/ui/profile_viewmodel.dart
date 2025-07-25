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
    /* `init` is called by the `ProfileBody` widget */
    // init();
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
    startProfileSubscription();
  }

  /* This method gets `uid` is from the auth repository aka,
  `FirebaseAuth.instance`, not the profile repository which is
   a Firestore collection aka, `FirebaseFirestore.instance`. */
  void startProfileSubscription() {
    uid = _authRepository.getUserId();
    email = _authRepository.getUserEmail();

    if (uid == null) return;

    if (_profileSubscription != null) return;

    _profileRepository.subscribeToProfileStream(uid: uid!, email: email!);

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
    isEditing = true;
    notifyListeners();
  }

  Future<String> removeInterest({required InterestModel interest}) async {
    String result = await _profileRepository.removeInterest(interest);
    if (result == Str.errorSavingProfile) return result;

    result = await _profileRepository.updateProfileTimestamp(uid!);
    return result;
  }

  Future<String> updateProfile({
    String? name,
    String? bio,
    InterestModel? interest,
  }) async {
    /* Utilized `tempList` to avoid duplicating the interest if `interests` got
      pulled from the server's stream before this method updates it. */
    final tempList = List<InterestModel>.from(interests);
    if (interest != null) {
      tempList.removeWhere((element) => element.id == interest.id);
      tempList.add(interest);
    }

    if (profile == null) {
      print(
        'Profile ViewModel - `updateProfile`: `profile` is null. Check `startProfileSubscription`.',
      );
      return Str.pleaseSignIn;
    }

    final newProfile = profile!.copyWith(
      name: name ?? profile!.name,
      bio: bio ?? profile!.bio,
      interests: tempList,
      lastEditedTime: DateTime.now().millisecondsSinceEpoch,
    );

    String? cannotEditMessage = validateProfileUpdates(newProfile);
    if (cannotEditMessage != null) {
      return cannotEditMessage;
    }

    await _profileRepository.updateProfile(newProfile);
    isEditing = false;

    // notifyListeners();

    return Str.profileSaved;
  }

  String? validateProfileUpdates(ProfileModel newProfile) {
    // check name exists. Double validation along with UI validation.
    if (newProfile.name.isEmpty) {
      return Str.fillRequiredFields;
    }

    bool edited = false;
    final profileMap = profile!.toMap();

    // Check if any field has changed
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

    if (!edited) return Str.noChanges;

    return null;
  }

  @override
  void dispose() {
    stopSubscriptions();
    super.dispose();
  }
}
