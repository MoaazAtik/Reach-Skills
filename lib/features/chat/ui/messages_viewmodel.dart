import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

import '../../auth/domain/auth_repository.dart';
import '../data/message_model.dart';
import '../domain/chat_repository.dart';

class MessagesViewModel extends ChangeNotifier {
  MessagesViewModel({
    required AuthRepository authRepository,
    required ChatRepository chatRepository,
  }) : _authRepository = authRepository,
       _chatRepository = chatRepository {
    init();
  }

  final AuthRepository _authRepository;
  final ChatRepository _chatRepository;

  String? chatId;
  String? currentSenderId;
  String? currentSenderName;
  String? currentReceiverId;
  String? currentReceiverName;
  List<MessageModel>? messages;
  bool loading = true;
  bool _loggedIn = false;

  bool get loggedIn => _loggedIn;

  StreamSubscription<User?>? _authStateSubscription;
  StreamSubscription<List<MessageModel>>? _messagesSubscription;

  void init() {
    startAuthStateSubscription();
    if (chatId != null) {
      startMessagesSubscription(chatId!);
    }
  }

  void updateFields({
    String? currentSenderId,
    String? currentSenderName,
    String? currentReceiverId,
    String? currentReceiverName,
  }) {
    this.currentSenderId = currentSenderId;
    this.currentSenderName = currentSenderName;
    this.currentReceiverId = currentReceiverId;
    this.currentReceiverName = currentReceiverName;

    // notifyListeners is called by setChatId

    getChatId();
  }

  Future<void> getChatId() async {
    String? chatId = await _chatRepository.getChatIdOrCreateChat(
      personAId: currentSenderId!,
      personAName: currentSenderName!,
      personBId: currentReceiverId!,
      personBName: currentReceiverName!,
    );

    setChatId(chatId!);
  }

  void setChatId(String chatId) {
    this.chatId = chatId;
    startMessagesSubscription(chatId);
    notifyListeners();
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
  }

  Future<void> sendMessage(String content) async {
    MessageModel messageModel = MessageModel.toBeStored(
      chatId: chatId!,
      senderId: currentSenderId!,
      senderName: currentSenderName!,
      receiverId: currentReceiverId!,
      receiverName: currentReceiverName!,
      content: content,
    );
    await _chatRepository.sendMessage(messageModel);
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

  @override
  void dispose() {
    _authStateSubscription?.cancel();
    _messagesSubscription?.cancel();
    super.dispose();
  }
}
