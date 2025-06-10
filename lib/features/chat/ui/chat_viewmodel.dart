import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
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
  bool _loggedIn = false;

  bool get loggedIn => _loggedIn;

  StreamSubscription<User?>? _authStateSubscription;
  StreamSubscription<List<ChatModel>>? _allChatsSubscription;

  void init() {
    startAuthStateSubscription();
    startAllChatsSubscription();
  }

  void startAuthStateSubscription() {
    _authStateSubscription = _authRepository.getAuthStateChanges().listen(
      (user) {
        if (user != null) {
          _loggedIn = true;
        } else {
          _loggedIn = false;
        }
        notifyListeners();
      },
      onError: (object, stackTrace) {
        _loggedIn = false;
        notifyListeners();
      },
    );
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
    _authStateSubscription?.cancel();
    _allChatsSubscription?.cancel();
  }
}
