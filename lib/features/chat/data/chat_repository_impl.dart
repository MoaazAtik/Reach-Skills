import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

import '../../../core/constants/strings.dart';
import '../domain/chat_repository.dart';
import 'chat_model.dart';
import 'message_model.dart';

class ChatRepositoryImpl extends ChatRepository {
  final _firestore = FirebaseFirestore.instance;

  int _chatsSubscriptionCount = 0;
  final StreamController<List<ChatModel>> _chatsController =
      StreamController<List<ChatModel>>.broadcast();
  StreamSubscription<QuerySnapshot<Map<String, dynamic>>>? _chatsSubscription;
  Stream<List<ChatModel>>? _chatsStream;

  @override
  Stream<List<ChatModel>>? get chatsStream => _chatsStream;

  final StreamController<List<MessageModel>> _messagesController =
      StreamController<List<MessageModel>>.broadcast();
  StreamSubscription<QuerySnapshot<Map<String, dynamic>>>?
  _messagesSubscription;
  int _messagesSubscriptionCount = 0;
  Stream<List<MessageModel>>? _messagesStream;

  @override
  Stream<List<MessageModel>>? get messagesStream {
    return _messagesStream;
  }

  @override
  void subscribeToChatsStream() {
    _chatsSubscriptionCount++;

    if (_chatsSubscriptionCount <= 1) {
      _chatsStream = _chatsController.stream;

      _chatsSubscription = _firestore
          .collection(Str.CHAT_COLLECTION_NAME)
          .orderBy(Str.CHAT_FIELD_UPDATED_AT, descending: true)
          .limit(50)
          .snapshots()
          .listen(
            (snapshot) {
              final List<ChatModel> allChats = [];
              for (var doc in snapshot.docs) {
                allChats.add(ChatModel.fromMapAndId(doc.id, doc.data()));
              }

              _chatsController.sink.add(allChats);
            },
            onError: ((error, stackTrace) {
              _chatsController.sink.addError(error);
              if (kDebugMode) {
                print('Messages Subscription Error. FirebaseException $error');
                print('stackTrace: $stackTrace');
              }
            }),
          );
    }

    _chatsController.onCancel = (() {
      _chatsSubscription?.cancel();
    });
  }

  @override
  void unsubscribeFromChatsStream() {
    _chatsSubscriptionCount--;
    if (_chatsSubscriptionCount < 1) {
      _chatsController.close();
      _chatsSubscription?.cancel();
    }
  }

  // from explore screen
  @override
  Future<String?> getChatIdOrCreateChat({
    required String personAId,
    required String personAName,
    required String personBId,
    required String personBName,
  }) async {
    String? chatId = await _getChatId(personAId, personBId);

    if (chatId != null) return chatId;

    chatId = await _createChat(personAId, personAName, personBId, personBName);

    if (chatId != null) {
      return chatId;
    } else {
      throw Exception('Could not get chat id nor create a new chat.');
    }
  }

  Future<String?> _getChatId(String personAId, String personBId) async {
    String? chatId;

    await _firestore
        .collection(Str.CHAT_COLLECTION_NAME)
        .where(
          Filter.and(
            Filter.or(
              Filter(Str.CHAT_FIELD_PERSON1_ID, isEqualTo: personAId),
              Filter(Str.CHAT_FIELD_PERSON2_ID, isEqualTo: personAId),
            ),
            Filter.or(
              Filter(Str.CHAT_FIELD_PERSON1_ID, isEqualTo: personBId),
              Filter(Str.CHAT_FIELD_PERSON2_ID, isEqualTo: personBId),
            ),
          ),
        )
        .get()
        .then((snapshot) {
          if (snapshot.docs.isNotEmpty) {
            chatId = snapshot.docs.first.id;
          }
        });

    return chatId;
  }

  Future<String?> _createChat(
    String senderId,
    String senderName,
    String receiverId,
    String receiverName,
  ) async {
    String? chatId;

    await _firestore
        .collection(Str.CHAT_COLLECTION_NAME)
        .add({
          // without ID. Firebase will generate one.
          Str.CHAT_FIELD_PERSON1_ID: senderId,
          Str.CHAT_FIELD_PERSON1_NAME: senderName,
          Str.CHAT_FIELD_PERSON2_ID: receiverId,
          Str.CHAT_FIELD_PERSON2_NAME: receiverName,
          Str.CHAT_FIELD_CREATED_AT: DateTime.now().millisecondsSinceEpoch,
          Str.CHAT_FIELD_UPDATED_AT: DateTime.now().millisecondsSinceEpoch,
        })
        .then((documentReference) {
          chatId = documentReference.id;
        });

    if (chatId != null) {
      return chatId;
    } else {
      throw Exception('Could not create a new chat.');
    }
  }

  @override
  Future<void> sendMessage(MessageModel messageModel) async {
    final messageModelMap = messageModel.toMap();
    final newDocRef = _firestore.collection(Str.MESSAGE_COLLECTION_NAME).doc();
    messageModelMap[Str.MESSAGE_FIELD_ID] = newDocRef.id;
    await newDocRef.set(messageModelMap);
  }

  @override
  void subscribeToMessagesStream(String chatId) {
    _messagesSubscriptionCount++;

    if (_messagesSubscriptionCount <= 1) {
      _messagesStream = _messagesController.stream;

      _messagesSubscription = _firestore
          .collection(Str.MESSAGE_COLLECTION_NAME)
          .where(Str.MESSAGE_FIELD_CHAT_ID, isEqualTo: chatId)
          .orderBy(Str.MESSAGE_FIELD_UPDATED_AT, descending: true)
          .limit(50)
          .snapshots()
          .listen(
            (snapshot) {
              final List<MessageModel> tempMessagesList = [];
              for (var doc in snapshot.docs) {
                tempMessagesList.add(
                  MessageModel.fromMapAndId(doc.id, doc.data()),
                );
              }

              _messagesController.sink.add(tempMessagesList);
            },
            onError: ((error, stackTrace) {
              /* error.runtimeType FirebaseException */
              _messagesController.sink.addError(error);
              if (kDebugMode) {
                print('Messages Subscription Error. FirebaseException $error');
                print('stackTrace: $stackTrace');
              }
            }),
          );
    }

    _messagesController.onCancel = (() {
      _messagesSubscription?.cancel();
    });
  }

  @override
  void unsubscribeFromMessagesStream() {
    _messagesSubscriptionCount--;
    if (_messagesSubscriptionCount < 1) {
      _messagesController.close();
      _messagesSubscription?.cancel();
    }
  }
}
