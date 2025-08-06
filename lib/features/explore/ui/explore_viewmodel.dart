import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:reach_skills/core/preferences_repository/domain/preferences_repository.dart';

import '../../../core/constants/strings.dart';
import '../../auth/domain/auth_repository.dart';
import '../../common/data/interest_model.dart';
import '../../profile/domain/profile_model.dart';
import '../../profile/domain/profile_repository.dart';

class ExploreViewModel extends ChangeNotifier {
  ExploreViewModel({required ProfileRepository profileRepository})
    : _profileRepository = profileRepository {
    init();
  }

  final ProfileRepository _profileRepository;

  StreamSubscription<List<InterestModel>>? _interestsSubscription;
  List<InterestModel> interests = [];

  // Todo replace '= InterestType.values' with values from UI
  List<InterestType> interestTypes = InterestType.values;
  String? interestsStreamError;
  bool loading = true;

  String? currentSenderId;
  String? currentSenderName;
  String? currentReceiverId;
  String? currentReceiverName;

  void init() {
    startInterestsSubscription(interestTypes);
    notifyListeners(); /* Investigate why app works fine even without this line. */
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

        // Todo test. Probably needed when another user updates his interests
        notifyListeners();
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
    print('explore view model - dispose');
    stopSubscriptions();
    super.dispose();
  }
}
