import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:reach_skills/core/preferences_repository/domain/preferences_repository.dart';

import '../../../core/constants/strings.dart';
import '../../auth/domain/auth_repository.dart';
import '../../common/data/interest_model.dart';
import '../../profile/domain/profile_model.dart';
import '../../profile/domain/profile_repository.dart';

class ExploreViewModel extends ChangeNotifier {
  ExploreViewModel({
    required PreferencesRepository preferencesRepository,
    required AuthRepository authRepository,
    required ProfileRepository profileRepository,
  }) : _preferencesRepository = preferencesRepository,
       _authRepository = authRepository,
       _profileRepository = profileRepository {
    init();
  }

  final PreferencesRepository _preferencesRepository;
  final AuthRepository _authRepository;
  final ProfileRepository _profileRepository;

  StreamSubscription<List<InterestModel>>? _interestsSubscription;
  List<InterestModel>? interests;
  // Todo replace '= InterestType.values' with values from UI
  List<InterestType> interestTypes = InterestType.values;
  String? interestsStreamError;
  bool loading = true;

  bool? isFirstInitialization;

  String? currentSenderId;
  String? currentSenderName;
  String? currentReceiverId;
  String? currentReceiverName;

  void init() {
    getIsFirstInitialization();
    startInterestsSubscription(interestTypes);
    notifyListeners(); /* Investigate why app works fine even without this line. */
  }

  Future<void> setIsFirstInitialization(bool value) async {
    await _preferencesRepository.setIsFirstInitialization(value);
    getIsFirstInitialization();
  }

  Future<void> getIsFirstInitialization() async {
    isFirstInitialization =
        await _preferencesRepository.isFirstInitialization();
    // notifyListeners();
  }

  Future<String?> updateFields({ // Todo remove
    required String currentReceiverId,
    required String currentReceiverName,
  }) async {
    currentSenderId = _authRepository.getUserId();

    if (currentSenderId == null) return Str.pleaseSignIn; // aka, not logged in

    /* to avoid sending message to yourself.
    otherwise, it conflicts with fetching chatId logic
    in the chat repo.*/
    if (currentReceiverId == currentSenderId) {
      return Str.cannotReachYourself;
    }

    ProfileModel? senderProfile;
    // Commented out because I replaced getProfile with subscribeToProfileStream
    // await _profileRepository.getProfile(currentSenderId!).then((value) {
    //   senderProfile = value;
    // });
    currentSenderName = senderProfile?.name;

    this.currentReceiverId = currentReceiverId;
    this.currentReceiverName = currentReceiverName;
    notifyListeners();

    return null; // aka, updated
  }

  void startInterestsSubscription(List<InterestType> interestTypes) {
    // cancel previous subscription when interest types change
    this.interestTypes = interestTypes;
    _interestsSubscription?.cancel();
    _profileRepository.subscribeToInterestsStream(interestTypes: interestTypes);

    _interestsSubscription = _profileRepository.interestsStream!.listen(
      (interests) {
        this.interests = interests;
        interestsStreamError = null;
        loading = false;
        // notifyListeners();
      },
      onError: (errorObject, stackTrace) {
        interestsStreamError = Str.serverErrorMessage;
        loading = false;
        // notifyListeners();
      },
    );
  }

  void stopSubscriptions() {
    _profileRepository.unsubscribeFromInterestsStream();
    _interestsSubscription?.cancel();
  }

  @override
  void dispose() {
    stopSubscriptions();
    super.dispose();
  }
}
