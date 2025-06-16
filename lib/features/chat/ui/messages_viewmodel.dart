import 'dart:async';

import 'package:flutter/foundation.dart';

import '../../../core/constants/strings.dart';
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

  bool loading = true;
  List<MessageModel>? messages;
  String? messagesError;
  bool _isLoggedIn = false;

  bool get isLoggedIn => _isLoggedIn;

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
  }

  void startMessagesSubscription(String chatId) {
    _chatRepository.subscribeToMessagesStream(chatId);

    if (_chatRepository.messagesStream == null) {
      loading = true;
    } else {
      _messagesSubscription = _chatRepository.messagesStream!.listen(
        (data) {
          messages = data;
          messagesError = null;
          loading = false;
          notifyListeners();
        },
        onError: (errorObject, stackTrace) {
          messagesError = Str.serverErrorMessage;
          loading = false;
          notifyListeners();
        },
      );
    }
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
    _authRepository.subscribeToAuthStateChanges();

    _isLoggedIn = _authRepository.isLoggedIn.value;
    notifyListeners();

    _authRepository.isLoggedIn.addListener(() {
      _isLoggedIn = _authRepository.isLoggedIn.value;
      notifyListeners();
    });
  }

  void stopSubscriptions() {
    _authRepository.unsubscribeFromAuthStateChanges();
    _chatRepository.unsubscribeFromMessagesStream();
    _messagesSubscription?.cancel();
  }

  @override
  void dispose() {
    stopSubscriptions();
    super.dispose();
  }
}
