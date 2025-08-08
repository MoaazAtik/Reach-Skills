import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

import '../../../core/constants/strings.dart';
import '../../auth/data/auth_repository_impl.dart';
import '../../auth/domain/auth_repository.dart';
import '../data/chat_model.dart';
import '../domain/chat_repository.dart';

enum ChatterProperty { id, name }

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
    print('init - Chat View Model');
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

    _authRepository.isLoggedIn.addListener(_listenerIsLoggedIn);
    _authRepository.currentUserNotifier.addListener(
      _listenerCurrentUserNotifier,
    );
    _authRepository.authError.addListener(_listenerAuthError);
  }

  void startAllChatsSubscription() {
    if (_currentUser == null) {
      print(
        '${Str.excMessageNullUser}'
        ' ${Str.excMessageStartAllChatsSubscription} - $runtimeType',
      );
      return;
    }

    _chatRepository.subscribeToChatsStream(_currentUser!.uid);

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

    _authRepository.isLoggedIn.removeListener(_listenerIsLoggedIn);
    _authRepository.currentUserNotifier.removeListener(
      _listenerCurrentUserNotifier,
    );
    (_authRepository as AuthRepositoryImpl).authError.removeListener(
      _listenerAuthError,
    );

    _chatRepository.unsubscribeFromChatsStream();
    _allChatsSubscription?.cancel();
  }

  void _listenerIsLoggedIn() {
    _isLoggedIn = _authRepository.isLoggedIn.value;
    notifyListeners();
  }

  void _listenerCurrentUserNotifier() {
    _currentUser = _authRepository.currentUserNotifier.value;
    _authError = null;
    startAllChatsSubscription();
    notifyListeners();
  }

  void _listenerAuthError() {
    _authError = (_authRepository as AuthRepositoryImpl).authError.value;
    notifyListeners();
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

  String determineChatterProperty({
    required ChatModel chat,
    required ChatterProperty property,
    bool mine = true,
  }) {
    if (property == ChatterProperty.id) {
      final person1Id = chat.person1Id;
      final person2Id = chat.person2Id;

      if (person1Id == _currentUser?.uid) {
        if (mine) {
          return person1Id;
        } else {
          return person2Id;
        }
      } else {
        if (mine) {
          return person2Id;
        } else {
          return person1Id;
        }
      }
    } else {
      // (property == ChatterProperty.name)
      final person1Name = chat.person1Name;
      final person2Name = chat.person2Name;
      if (person1Name == _currentUser?.displayName) {
        if (mine) {
          return person1Name;
        } else {
          return person2Name;
        }
      } else {
        if (mine) {
          return person2Name;
        } else {
          return person1Name;
        }
      }
    }
  }

  Map<String, String>? packChattersProperties({required ChatModel chat}) {
    if (_currentUser == null) {
      print(
        '${Str.excMessageNullUser}'
        ' ${Str.excMessagePackChattersProperties} - $runtimeType',
      );
      return null;
    }

    final Map<String, String> properties = {};

    final chatId = chat.id;

    final currentSenderId = determineChatterProperty(
      chat: chat,
      property: ChatterProperty.id,
      mine: true,
    );
    final currentSenderName = determineChatterProperty(
      chat: chat,
      property: ChatterProperty.name,
      mine: true,
    );
    final currentReceiverId = determineChatterProperty(
      chat: chat,
      property: ChatterProperty.id,
      mine: false,
    );
    final currentReceiverName = determineChatterProperty(
      chat: chat,
      property: ChatterProperty.name,
      mine: false,
    );

    properties[Str.messagesScreenParamChatId] = chatId;
    properties[Str.messagesScreenParamCurrentSenderId] = currentSenderId;
    properties[Str.messagesScreenParamCurrentSenderName] = currentSenderName;
    properties[Str.messagesScreenParamCurrentReceiverId] = currentReceiverId;
    properties[Str.messagesScreenParamCurrentReceiverName] =
        currentReceiverName;
    return properties;
  }

  @override
  void dispose() {
    print('dispose - Chat ViewModel');
    stopSubscriptions();
    super.dispose();
  }
}
