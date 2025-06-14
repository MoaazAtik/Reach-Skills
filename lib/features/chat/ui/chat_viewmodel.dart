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
  List<ChatModel>? allChats;
  bool _isLoggedIn = false;

  bool get isLoggedIn => _isLoggedIn;

  StreamSubscription<bool>? _isLoggedInSubscription;
  StreamSubscription<List<ChatModel>>? _allChatsSubscription;

  void init() {
    startAuthStateSubscription();
    startAllChatsSubscription();
  }

  void startAuthStateSubscription() {
    _authRepository.subscribeToAuthStateChanges();

    _isLoggedInSubscription = _authRepository.isLoggedIn.listen((isLoggedIn) {
      _isLoggedIn = isLoggedIn;
      notifyListeners();
    });
  }

  void startAllChatsSubscription() {
    _allChatsSubscription = _chatRepository.getAllChatsStream().listen((
      allChats,
    ) {
      loading = true;
      this.allChats = allChats;
      loading = false;
      notifyListeners();
    });
  }

  @override
  void dispose() {
    super.dispose();
    _authRepository.unsubscribeFromAuthStateChanges();
    _isLoggedInSubscription?.cancel();
    _allChatsSubscription?.cancel();
  }
}
