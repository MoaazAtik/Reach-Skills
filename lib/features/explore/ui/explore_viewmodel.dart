import 'dart:async';

import 'package:flutter/foundation.dart';

import '../../../core/constants/strings.dart';
import '../../auth/ui/auth_viewmodel.dart';
import '../../chat/domain/chat_repository.dart';
import '../../common/data/interest_model.dart';
import '../../profile/domain/profile_repository.dart';

class ExploreViewModel extends ChangeNotifier {
  ExploreViewModel({
    required AuthViewModel authViewModel,
    required ProfileRepository profileRepository,
  }) : _authViewModel = authViewModel,
       _profileRepository = profileRepository {
    init();
  }

  final AuthViewModel _authViewModel;
  final ProfileRepository _profileRepository;

  StreamSubscription<List<InterestModel>>? _interestsSubscription;
  List<InterestModel> interests = [];

  List<InterestType> interestTypes = InterestType.values;
  String? interestsStreamError;
  bool loading = true;

  String? currentSenderId;
  String? currentSenderName;
  bool? isLoggedIn;

  void init() {
    _initializeAndListenToFields();
    startInterestsSubscription(interestTypes);
    notifyListeners(); /* Investigate why app works fine even without this line. */
  }

  Future<Map<String, String>?> packChatId(
    Map<String, String> chatPropertiesPack,
    ChatRepository chatRepository,
  ) async {
    if (chatPropertiesPack[Str.messagesScreenParamCurrentSenderId] == null ||
        chatPropertiesPack[Str.messagesScreenParamCurrentSenderName] == null ||
        chatPropertiesPack[Str.messagesScreenParamCurrentReceiverId] == null ||
        chatPropertiesPack[Str.messagesScreenParamCurrentReceiverName] ==
            null) {
      print(
        '${Str.excMessageMissingChatPropertiesPack}'
        ' ${Str.excMessageOnTapReach} - $runtimeType'
        '\n  chatPropertiesPack: $chatPropertiesPack',
      );
      return null;
    }

    String? currentSenderId =
        chatPropertiesPack[Str.messagesScreenParamCurrentSenderId]!;
    String? currentSenderName =
        chatPropertiesPack[Str.messagesScreenParamCurrentSenderName]!;
    String? currentReceiverId =
        chatPropertiesPack[Str.messagesScreenParamCurrentReceiverId]!;
    String? currentReceiverName =
        chatPropertiesPack[Str.messagesScreenParamCurrentReceiverName]!;

    String? chatId = await chatRepository.getChatIdOrCreateChat(
      personAId: currentSenderId,
      personAName: currentSenderName,
      personBId: currentReceiverId,
      personBName: currentReceiverName,
    );

    if (chatId == null) {
      print(
        '${Str.excMessageNullChatId}'
        ' ${Str.excMessagePackChatId} - $runtimeType'
        '\n  chatPropertiesPack: $chatPropertiesPack',
      );
      return null;
    }

    chatPropertiesPack[Str.messagesScreenParamChatId] = chatId;

    return chatPropertiesPack;
  }

  void _initializeAndListenToFields() {
    // Initialize fields
    isLoggedIn = _authViewModel.isLoggedIn;
    getCurrentUserIdAndName();

    // Listen to changes
    _authViewModel.addListener(_listenerAuth);
  }

  void _listenerAuth() {
    isLoggedIn = _authViewModel.isLoggedIn;
    currentSenderId = _authViewModel.currentUser?.uid;
    currentSenderName = _authViewModel.currentUser?.displayName;
    notifyListeners();
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
        // notifyListeners();
      },
    );
  }

  /// Get current user id and name to be passed through `InterestDetails` screen
  /// when tapping `Reach` button.
  void getCurrentUserIdAndName() {
    /*
    Null check is done by `InterestDetails` screen when calling `onTapReach`.
     */
    currentSenderId = _authViewModel.currentUser?.uid;
    currentSenderName = _authViewModel.currentUser?.displayName;
  }

  /// Pass `immediately = true` to cancel the previous subscription immediately
  /// only when you change the `interest types` filter aka, when you call
  /// `startInterestsSubscription` with a different `interestTypes` value.
  void stopSubscriptions({bool immediately = false}) {
    _profileRepository.unsubscribeFromInterestsStream(immediately: immediately);
    _interestsSubscription?.cancel();
    _authViewModel.removeListener(_listenerAuth);
  }

  @override
  void dispose() {
    print('explore view model - dispose');
    stopSubscriptions();
    super.dispose();
  }
}
