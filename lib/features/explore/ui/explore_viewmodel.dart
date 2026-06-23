import 'dart:async';

import 'package:flutter/foundation.dart';

import '../../../core/constants/strings.dart';
import '../../auth/domain/entities/auth_session.dart';
import '../../auth/domain/use_cases/get_auth_session_use_case.dart';
import '../../common/data/interest_model.dart';
import '../../profile/domain/profile_repository.dart';

class ExploreViewModel extends ChangeNotifier {
  ExploreViewModel({
    required GetAuthSessionUseCase getAuthSessionUseCase,
    required ProfileRepository profileRepository,
  }) : _getAuthSessionUseCase = getAuthSessionUseCase,
       _profileRepository = profileRepository {
    init();
  }

  final GetAuthSessionUseCase _getAuthSessionUseCase;
  final ProfileRepository _profileRepository;

  StreamSubscription<List<InterestModel>>? _interestsSubscription;
  StreamSubscription<AuthSession>? _authSessionSubscription;

  List<InterestModel> interests = [];

  List<InterestType> interestTypes = InterestType.values;
  String? interestsStreamError;
  bool loading = true;

  String? currentSenderId;
  String? currentSenderName;
  bool? isLoggedIn;

  void init() {
    _subscribeToAuthSession();
    startInterestsSubscription(interestTypes);
    notifyListeners(); /* Investigate why app works fine even without this line. */
  }

  void _subscribeToAuthSession() {
    _authSessionSubscription = _getAuthSessionUseCase.execute().listen((
      session,
    ) {
      isLoggedIn = session.isLoggedIn;

      /// Get current user id and name to be passed through `InterestDetails`
      /// screen when tapping `Reach` button.
      /*
      Null check is done by `InterestDetails` screen when calling `onTapReach`.
      */
      currentSenderId = session.user?.uid;
      currentSenderName = session.user?.displayName;
      notifyListeners();
    });
  }

  void startInterestsSubscription(List<InterestType> interestTypes) {
    if (_interestsSubscription != null) {
      if (this.interestTypes == interestTypes) return;
      // cancel previous subscription when interest types change
      stopSubscriptions(immediately: true);
    }

    this.interestTypes = interestTypes;
    _profileRepository.subscribeToInterestsStream(interestTypes: interestTypes);

    _interestsSubscription = _profileRepository.interestsStream!.listen(
      (interests) {
        this.interests = interests;
        interestsStreamError = null;
        loading = false;

        // Todo test. Probably needed when another user updates his interests
        notifyListeners();
      },
      onError: (errorObject, stackTrace) {
        interestsStreamError = Str.serverErrorMessage;
        loading = false;
        notifyListeners();
      },
    );
  }

  /// Pass `immediately = true` to cancel the previous subscription immediately
  /// only when you change the `interest types` filter aka, when you call
  /// `startInterestsSubscription` with a different `interestTypes` value.
  void stopSubscriptions({bool immediately = false}) {
    _profileRepository.unsubscribeFromInterestsStream(immediately: immediately);
    _interestsSubscription?.cancel();
    _authSessionSubscription?.cancel();
  }

  @override
  void dispose() {
    print('explore view model - dispose');
    stopSubscriptions();
    super.dispose();
  }
}
