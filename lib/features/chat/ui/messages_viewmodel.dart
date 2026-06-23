import 'dart:async';

import 'package:flutter/foundation.dart';

import '../../../core/constants/strings.dart';
import '../../auth/domain/entities/auth_session.dart';
import '../../auth/domain/use_cases/get_auth_session_use_case.dart';
import '../data/message_model.dart';
import '../domain/chat_repository.dart';

class MessagesViewModel extends ChangeNotifier {
  MessagesViewModel({
    required GetAuthSessionUseCase getAuthSessionUseCase,
    required ChatRepository chatRepository,
    required Map<String, dynamic> chatPropertiesPack,
  }) : _getAuthSessionUseCase = getAuthSessionUseCase,
       _chatRepository = chatRepository {
    init(chatPropertiesPack);
  }

  final GetAuthSessionUseCase _getAuthSessionUseCase;
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
  StreamSubscription<AuthSession>? _authSessionSubscription;

  void init(Map<String, dynamic> chatPropertiesPack) {
    updateFields(chatPropertiesPack);
    _subscribeToAuthSession();
    startMessagesSubscription();
  }

  void updateFields(Map<String, dynamic> chatPropertiesPack) {
    if (chatPropertiesPack[Str.messagesScreenParamChatId] == null ||
        chatPropertiesPack[Str.messagesScreenParamCurrentSenderId] == null ||
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

    chatId = chatPropertiesPack[Str.messagesScreenParamChatId]!;
    currentSenderId =
        chatPropertiesPack[Str.messagesScreenParamCurrentSenderId]!;
    currentSenderName =
        chatPropertiesPack[Str.messagesScreenParamCurrentSenderName]!;
    currentReceiverId =
        chatPropertiesPack[Str.messagesScreenParamCurrentReceiverId]!;
    currentReceiverName =
        chatPropertiesPack[Str.messagesScreenParamCurrentReceiverName]!;

    /*
    `notifyListeners` is called by `startMessagesSubscription` that should be
    called after this function is called.
    */
  }

  void _subscribeToAuthSession() {
    _authSessionSubscription = _getAuthSessionUseCase.execute().listen((
      session,
    ) {
      _isLoggedIn = session.isLoggedIn;
      notifyListeners();
    });
  }

  void startMessagesSubscription() {
    if (chatId == null || currentSenderId == null) {
      print(
        '${Str.excMessageNullCurrentSenderId} Or ${Str.excMessageNullChatId}'
        ' ${Str.excMessageStartMessagesSubscription} - $runtimeType',
      );
      return;
    }

    _chatRepository.subscribeToMessagesStream(chatId!, currentSenderId!);

    if (_chatRepository.messagesStream == null) {
      print(
        '${Str.excMessageNullMessagesStream}'
        ' ${Str.excMessageStartMessagesSubscription} - $this',
      );
      return;
    }

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

  Future<void> sendMessage(String content) async {
    if (chatId == null ||
        currentSenderId == null ||
        currentSenderName == null ||
        currentReceiverId == null ||
        currentReceiverName == null) {
      print(
        '${Str.excMessageNullFields}'
        ' ${Str.excMessageSendMessage} - $runtimeType',
      );
      return;
    }

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

  Future<void> removeMessage(MessageModel message, int messageIndex) async {
    if (messages == null) return;

    MessageModel? lastMessage;
    /*
    Remember that messages are fetched from Database in reverse chronological
    order, ie, Newest first.
    */
    int olderMessageIndex = messageIndex + 1;

    if (messageIndex != 0 || olderMessageIndex > messages!.length - 1) {
      lastMessage = null;
    } else {
      lastMessage = messages![olderMessageIndex];
    }

    await _chatRepository.removeMessage(message, lastMessage);
  }

  void stopSubscriptions() {
    _authSessionSubscription?.cancel();
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
