import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

import '../../../core/constants/strings.dart';
import '../../auth/domain/entities/auth_session.dart';
import '../../auth/domain/use_cases/get_auth_session_use_case.dart';
import '../data/chat_model.dart';
import '../domain/chat_repository.dart';

enum ChatterProperty { id, name }

class ChatViewModel extends ChangeNotifier {
  ChatViewModel({
    required GetAuthSessionUseCase getAuthSessionUseCase,
    required ChatRepository chatRepository,
  }) : _getAuthSessionUseCase = getAuthSessionUseCase,
       _chatRepository = chatRepository {
    init();
  }

  final GetAuthSessionUseCase _getAuthSessionUseCase;
  final ChatRepository _chatRepository;

  bool loading = true;
  bool _isLoggedIn = false;

  bool get isLoggedIn => _isLoggedIn;
  User? _currentUser;
  String? _authError;

  String? get authError => _authError;

  List<ChatModel>? _allChats;

  List<ChatModel>? get allChats => _allChats;
  String? _chatsError;

  String? get chatsError => _chatsError;
  StreamSubscription<List<ChatModel>>? _allChatsSubscription;
  StreamSubscription<AuthSession>? _authSessionSubscription;

  void init() {
    print('init - Chat View Model');
    _subscribeToAuthSession();
    startAllChatsSubscription();
  }

  void _subscribeToAuthSession() {
    _authSessionSubscription = _getAuthSessionUseCase.execute().listen((
      session,
    ) {
      _isLoggedIn = session.isLoggedIn;
      _currentUser = session.user;
      _authError = session.error;

      if (_isLoggedIn && _currentUser != null) {
        startAllChatsSubscription();
      } else {
        stopAllChatsSubscription();
      }
      notifyListeners();
    });
  }

  void startAllChatsSubscription() {
    if (_currentUser == null) {
      print(
        '${Str.excMessageNullUser}'
        ' ${Str.excMessageStartAllChatsSubscription} - $runtimeType',
      );
      return;
    }

    if (_allChatsSubscription != null) return;

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

  void stopAllChatsSubscription() {
    _chatRepository.unsubscribeFromChatsStream();
    _allChatsSubscription?.cancel();
    _allChatsSubscription = null;
  }

  void stopSubscriptions() {
    _authSessionSubscription?.cancel();
    stopAllChatsSubscription();
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
