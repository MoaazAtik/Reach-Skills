import 'package:flutter/foundation.dart';

import '../../common/data/interest_model.dart';
import '../../profile/domain/profile_repository.dart';

class ExploreViewModel extends ChangeNotifier {
  ExploreViewModel({required ProfileRepository profileRepository})
    : _profileRepository = profileRepository {
    init();
  }

  final ProfileRepository _profileRepository;
  List<InterestModel>? interests;
  List<InterestType> interestTypes = [InterestType.skill, InterestType.wish];
  bool loading = true;

  void init() {
    getInterests(interestTypes);
  }

  Future<void> getInterests(List<InterestType> interestTypes) async {
    loading = true;
    this.interestTypes = interestTypes;
    interests = await _profileRepository.getInterests(interestTypes);
    loading = false;
    notifyListeners();
  }
}
