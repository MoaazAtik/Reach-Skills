import 'dart:async';

import 'package:flutter/foundation.dart';

import '../../common/data/interest_model.dart';
import '../../profile/domain/profile_repository.dart';

class ExploreViewModel extends ChangeNotifier {
  ExploreViewModel({required ProfileRepository profileRepository})
    : _profileRepository = profileRepository {
    init();
  }

  final ProfileRepository _profileRepository;
  StreamSubscription<List<InterestModel>>? _interestsSubscription;
  List<InterestModel>? interests;
  List<InterestType> interestTypes = [InterestType.skill, InterestType.wish];
  bool loading = true;

  void init() {
    startInterestsSubscription(interestTypes);
  }

  void startInterestsSubscription(List<InterestType> interestTypes) {
    // cancel previous subscription when interest types change
    _interestsSubscription?.cancel();

    this.interestTypes = interestTypes;
    _interestsSubscription = _profileRepository
        .getInterestsStream(interestTypes)
        .listen((interests) {
          loading = true;
          this.interests = interests;
          loading = false;
          notifyListeners();
        });
  }

  @override
  void dispose() {
    super.dispose();
    _interestsSubscription?.cancel();
  }
}
