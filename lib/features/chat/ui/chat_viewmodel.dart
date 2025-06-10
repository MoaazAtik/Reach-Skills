import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

import '../../auth/domain/auth_repository.dart';
import '../data/chat_model.dart';
import '../data/message_model.dart';
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
  List<MessageModel>? messages;
  bool _loggedIn = false;

  bool get loggedIn => _loggedIn;

  StreamSubscription<User?>? _authStateSubscription;
  StreamSubscription<List<ChatModel>>? _allChatsSubscription;
  StreamSubscription<List<MessageModel>>? _messagesSubscription;

  void init() {
    startAuthStateSubscription();
    startAllChatsSubscription();

    // temporary for testing purposes
    // startMessagesSubscription('6hpVaSPv2EW0tPht8l8K');
    // _chatRepository.sendMessage(
    //   senderId: 'uYGz8nhkXnUDqwtK0ewpvQTKqyl2',
    //   senderName: 'Albert',
    //   receiverId: 'ytrbrAbAQJapK1QpEJ8t2i0IMaM2',
    //   receiverName: 'NewUs',
    //   content: 'test message',
    // );

    // print(allChats);
    // print(messages);
  }

  void sendMessage(String chatId, String content) {
    // final message = MessageModel(
    //   id: DateTime.now().millisecondsSinceEpoch.toString(),
    //   chatId: chatId,
    //   createdAt: DateTime.now().millisecondsSinceEpoch,
    //   updatedAt: DateTime.now().millisecondsSinceEpoch,
    //   content: content,
    // );
    _chatRepository.sendMessageWithChatId(chatId: chatId, content: content);
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

  void startMessagesSubscription(String chatId) {
    _messagesSubscription = _chatRepository.getMessagesStream(chatId).listen((
      messages,
    ) {
      loading = true;
      this.messages = messages;
      loading = false;
      notifyListeners();
    });
    print('messages $messages');
  }

  @override
  void dispose() {
    super.dispose();
    _authStateSubscription?.cancel();
    _allChatsSubscription?.cancel();
    _messagesSubscription?.cancel();
  }
}
