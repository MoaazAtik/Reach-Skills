import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

import '../../../core/constants/strings.dart';
import '../../auth/data/auth_repository_impl.dart';
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
  User? _currentUser;
  String? _authError;

  String? get authError => _authError;
  String? currentSenderId;
  String? currentSenderName;
  String? currentReceiverId;
  String? currentReceiverName;

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
    _currentUser = _authRepository.currentUserNotifier.value;
    _authError = (_authRepository as AuthRepositoryImpl).authError.value;
    notifyListeners();

    _authRepository.isLoggedIn.addListener(() {
      _isLoggedIn = _authRepository.isLoggedIn.value;
      notifyListeners();
    });

    _authRepository.currentUserNotifier.addListener(() {
      _currentUser = _authRepository.currentUserNotifier.value;
      _authError = null;
      notifyListeners();
    });

    _authRepository.authError.addListener(() {
      _authError = _authRepository.authError.value;
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
          _chatsError = Str.serverErrorMessage;
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

  void updateSelectedChatFields(ChatModel chat) {
    if (_currentUser!.uid == chat.person1Id) {
      currentSenderId = chat.person1Id;
      currentSenderName = chat.person1Name;
      currentReceiverId = chat.person2Id;
      currentReceiverName = chat.person2Name;
    } else {
      currentSenderId = chat.person2Id;
      currentSenderName = chat.person2Name;
      currentReceiverId = chat.person1Id;
      currentReceiverName = chat.person1Name;
    }
  }

  @override
  void dispose() {
    stopSubscriptions();
    super.dispose();
  }
}
