import 'dart:async';

import 'package:flutter/foundation.dart';

import '../../auth/domain/auth_repository.dart';
import '../../common/data/interest_model.dart';
import '../../profile/domain/profile_model.dart';
import '../../profile/domain/profile_repository.dart';

class ExploreViewModel extends ChangeNotifier {
  ExploreViewModel({
    required AuthRepository authRepository,
    required ProfileRepository profileRepository,
  }) : _authRepository = authRepository,
       _profileRepository = profileRepository {
    init();
  }

  final AuthRepository _authRepository;
  final ProfileRepository _profileRepository;

  StreamSubscription<List<InterestModel>>? _interestsSubscription;
  List<InterestModel>? interests;
  List<InterestType> interestTypes = [InterestType.skill, InterestType.wish];
  bool loading = true;

  String? currentSenderId;
  String? currentSenderName;
  String? currentReceiverId;
  String? currentReceiverName;

  void init() {
    startInterestsSubscription(interestTypes);
  }

  Future<String?> updateFields({
    required String currentReceiverId,
    required String currentReceiverName,
  }) async {
    currentSenderId = _authRepository.getUserId();

    if (currentSenderId == null) return 'Please sign in.'; // aka, not logged in

    /* to avoid sending message to yourself.
    otherwise, it conflicts with fetching chatId logic
    in the chat repo.*/
    if (currentReceiverId == currentSenderId) {
      return 'Trying to reach yourself?';
    }

    ProfileModel? senderProfile;
    await _profileRepository.getProfile(currentSenderId!).then((value) {
      senderProfile = value;
    });
    currentSenderName = senderProfile?.name;

    this.currentReceiverId = currentReceiverId;
    this.currentReceiverName = currentReceiverName;
    notifyListeners();

    return null; // aka, updated
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
