import 'dart:async';

import 'package:flutter/foundation.dart';

import '../../../core/constants/strings.dart';
import '../../auth/domain/entities/auth_session.dart';
import '../../auth/domain/use_cases/get_auth_session_use_case.dart';
import '../../common/data/interest_model.dart';
import '../domain/profile_model.dart';
import '../domain/profile_repository.dart';

class ProfileViewModel extends ChangeNotifier {
  ProfileViewModel({
    required GetAuthSessionUseCase getAuthSessionUseCase,
    required ProfileRepository profileRepository,
  }) : _getAuthSessionUseCase = getAuthSessionUseCase,
       _profileRepository = profileRepository {
    init();
  }

  final GetAuthSessionUseCase _getAuthSessionUseCase;
  final ProfileRepository _profileRepository;

  StreamSubscription<AuthSession>? _authSessionSubscription;
  bool loading = true;
  bool isEditing = false;
  String? uid;
  String? email;
  ProfileModel? profile;

  List<InterestModel> interests = [];
  StreamSubscription<ProfileModel>? _profileSubscription;
  String? profileStreamError;
  bool isLoggedIn = false;

  void init() {
    _subscribeToAuthSession();
    // startInterestsSubscription();
  }

  void _subscribeToAuthSession() {
    _authSessionSubscription = _getAuthSessionUseCase.execute().listen((
      session,
    ) {
      isLoggedIn = session.isLoggedIn;
      uid = session.user?.uid;
      email = session.user?.email;

      if (isLoggedIn && uid != null) {
        startProfileSubscription();
      } else {
        stopProfileSubscription();
      }
      notifyListeners();
    });
  }

  /* This method gets `uid` is from the auth repository aka,
  `FirebaseAuth.instance`, not the profile repository which is
   a Firestore collection aka, `FirebaseFirestore.instance`. */
  void startProfileSubscription() {
    if (uid == null || email == null) {
      print('$this - `startProfileSubscription`: "null uid or email",');
      return;
    }
    if (_profileSubscription != null) return;

    _profileRepository.subscribeToProfileStream(uid: uid!, email: email!);

    _profileSubscription = _profileRepository.profileStream!.listen(
      (profile) {
        this.profile = profile;

        interests = List<InterestModel>.from(profile.interests);
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

  Future<void> stopSubscriptions() async {
    _authSessionSubscription?.cancel();
    stopProfileSubscription();
  }

  Future<void> stopProfileSubscription() async {
    await _profileRepository.unsubscribeFromProfileStream();
    await _profileSubscription?.cancel();
  }

  void toggleEdit() {
    isEditing = true;
    notifyListeners();
  }

  Future<String> removeInterest({required InterestModel interest}) async {
    if (uid == null) return Str.pleaseSignIn;

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
    if (uid == null) {
      print(
        'Profile ViewModel - `updateProfile`: "null uid".'
        ' Check `_authRepository.getUserId()`.',
      );
      return Str.pleaseSignIn;
    }

    /* This is needed because `startProfileSubscription` is called only on
   `ProfileBody`s initialization. Therefore, `profile` would be null when
    calling `updateProfile` to update an interest from the `ExploreScreen`. */
    if (profile == null && _profileSubscription == null) {
      profile = await _profileRepository.getProfile(uid!);
      interests = profile?.interests ?? interests;
    }

    if (profile == null) {
      print(
        'Profile ViewModel - `updateProfile`: `profile` is null.'
        ' Check `startProfileSubscription`.',
      );
      return Str.pleaseSignIn;
    }

    /* Utilized `tempList` to avoid duplicating the interest if `interests` got
      pulled from the server's stream before this method updates it. */
    final tempList = List<InterestModel>.from(interests);
    if (interest != null) {
      tempList.removeWhere((element) => element.id == interest.id);
      tempList.add(interest);
    }

    final newProfile = profile!.copyWith(
      name: name ?? profile!.name,
      bio: bio ?? profile!.bio,
      interests: tempList,
      lastEditedTime: DateTime.now().millisecondsSinceEpoch,
    );

    String? cannotEditMessage = validateProfileUpdates(newProfile);
    if (cannotEditMessage != null) {
      isEditing = false;
      notifyListeners();
      return cannotEditMessage;
    }

    await _profileRepository.updateProfile(newProfile);

    isEditing = false;
    notifyListeners();

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
        if (newProfile.interests.length != profile!.interests.length) {
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
