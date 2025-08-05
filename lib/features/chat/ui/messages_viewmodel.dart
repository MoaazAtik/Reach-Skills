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
    print('init - Messages ViewModel');
    startAuthStateSubscription();
  }

  void updateFields(Map<String, String> chatPropertiesPack) {
    /*
     chatPropertiesPack[Str.messagesScreenParamChatId] will be null when coming
     form Explore Screen aka, when 'Reach' is tapped.
    */
    if (chatPropertiesPack[Str.messagesScreenParamCurrentSenderId] == null ||
        chatPropertiesPack[Str.messagesScreenParamCurrentSenderName] == null ||
        chatPropertiesPack[Str.messagesScreenParamCurrentReceiverId] == null ||
        chatPropertiesPack[Str.messagesScreenParamCurrentReceiverName] ==
            null) {
      print(
        '${Str.excMessageMissingChatPropertiesPack}'
        ' ${Str.excMessageUpdateFields} - $runtimeType'
        '\n  chatPropertiesPack: $chatPropertiesPack',
      );
      return;
    }

    currentSenderId =
        chatPropertiesPack[Str.messagesScreenParamCurrentSenderId]!;
    currentSenderName =
        chatPropertiesPack[Str.messagesScreenParamCurrentSenderName]!;
    currentReceiverId =
        chatPropertiesPack[Str.messagesScreenParamCurrentReceiverId]!;
    currentReceiverName =
        chatPropertiesPack[Str.messagesScreenParamCurrentReceiverName]!;

    final chatId = chatPropertiesPack[Str.messagesScreenParamChatId];

    /* notifyListeners is called via setChatId by startMessagesSubscription */

    chatId != null ? setChatId(chatId) : getChatId();
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
    if (currentSenderId == null) {
      print(
        '${Str.excMessageNullCurrentSenderId}'
        ' ${Str.excMessageStartMessagesSubscription} - $runtimeType',
      );
      return;
    }

    _chatRepository.subscribeToMessagesStream(chatId, currentSenderId!);

    if (_chatRepository.messagesStream == null) {
      // Todo check this logic
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
    print('dispose - Messages ViewModel');
    stopSubscriptions();
    super.dispose();
  }
}
