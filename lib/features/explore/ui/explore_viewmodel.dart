import 'package:flutter/foundation.dart';

import '../../profile/domain/profile_repository.dart';

class ExploreViewModel extends ChangeNotifier {
  ExploreViewModel({required ProfileRepository profileRepository})
    : _profileRepository = profileRepository {
    init();
  }

  final ProfileRepository _profileRepository;
  Set<String>? skills;
  bool loading = true;

  void init() {
    getSkills();
  }

  Future<void> getSkills() async {
    skills = await _profileRepository.getSkills();
    loading = false;
    notifyListeners();
  }
}
