import 'dart:async';

import 'package:flutter/foundation.dart';

import '../../auth/domain/auth_repository.dart';
import '../data/chat_model.dart';
import '../domain/chat_repository.dart';

class ChatViewModel extends ChangeNotifier {
  ChatViewModel({
    required AuthRepository authRepository,
    required ChatRepository chatRepository,
  }) : _authRepository = authRepository,
       _chatRepository = chatRepository {
    init();
  }

  final AuthRepository _authRepository;
  final ChatRepository _chatRepository;

  bool loading = true;
  bool _isLoggedIn = false;

  bool get isLoggedIn => _isLoggedIn;

  List<ChatModel>? _allChats;

  List<ChatModel>? get allChats => _allChats;
  String? _chatsError;

  String? get chatsError => _chatsError;
  StreamSubscription<List<ChatModel>>? _allChatsSubscription;

  void init() {
    startAuthStateSubscription();
    startAllChatsSubscription();
  }

  void startAuthStateSubscription() {
    _authRepository.subscribeToAuthStateChanges();

    _isLoggedIn = _authRepository.isLoggedIn.value;
    notifyListeners();

    _authRepository.isLoggedIn.addListener(() {
      _isLoggedIn = _authRepository.isLoggedIn.value;
      notifyListeners();
    });
  }

  void startAllChatsSubscription() {
    _chatRepository.subscribeToChatsStream();

    if (_chatRepository.chatsStream != null) {
      _allChatsSubscription = _chatRepository.chatsStream!.listen(
        (allChats) {
          _allChats = allChats;
          _chatsError = null;
          loading = false;
          notifyListeners();
        },
        onError: (errorObject, stackTrace) {
          _chatsError =
              'Server error.\nPlease contact our support team or try again later.';
          loading = false;
          notifyListeners();
        },
      );
    }
  }

  void stopSubscriptions() {
    _authRepository.unsubscribeFromAuthStateChanges();

    _chatRepository.unsubscribeFromChatsStream();
    _allChatsSubscription?.cancel();
  }

  @override
  void dispose() {
    stopSubscriptions();
    super.dispose();
  }
}
