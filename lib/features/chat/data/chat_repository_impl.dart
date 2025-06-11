import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../domain/chat_repository.dart';
import 'chat_model.dart';
import 'message_model.dart';

class ChatRepositoryImpl extends ChatRepository {
  final _firestore = FirebaseFirestore.instance;

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
        .collection(ChatModel.COLLECTION_NAME)
        .where(
          Filter.and(
            Filter.or(
              Filter(ChatModel.FIELD_PERSON1_ID, isEqualTo: personAId),
              Filter(ChatModel.FIELD_PERSON2_ID, isEqualTo: personAId),
            ),
            Filter.or(
              Filter(ChatModel.FIELD_PERSON1_ID, isEqualTo: personBId),
              Filter(ChatModel.FIELD_PERSON2_ID, isEqualTo: personBId),
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
        .collection(ChatModel.COLLECTION_NAME)
        .add({
          // without ID. Firebase will generate one.
          ChatModel.FIELD_PERSON1_ID: senderId,
          ChatModel.FIELD_PERSON1_NAME: senderName,
          ChatModel.FIELD_PERSON2_ID: receiverId,
          ChatModel.FIELD_PERSON2_NAME: receiverName,
          ChatModel.FIELD_CREATED_AT: DateTime.now().millisecondsSinceEpoch,
          ChatModel.FIELD_UPDATED_AT: DateTime.now().millisecondsSinceEpoch,
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
    final newDocRef = _firestore.collection(MessageModel.COLLECTION_NAME).doc();
    messageModelMap[MessageModel.FIELD_ID] = newDocRef.id;
    await newDocRef.set(messageModelMap);
  }

  @override
  Stream<List<MessageModel>> getMessagesStream(String chatId) {
    final controller = StreamController<List<MessageModel>>();
    final subscription = _firestore
        .collection(MessageModel.COLLECTION_NAME)
        .where(MessageModel.FIELD_CHAT_ID, isEqualTo: chatId)
        .orderBy(MessageModel.FIELD_UPDATED_AT, descending: true)
        .limit(50)
        .snapshots()
        .listen((snapshot) {
          final List<MessageModel> messages = [];
          for (var doc in snapshot.docs) {
            messages.add(MessageModel.fromMapAndId(doc.id, doc.data()));
          }
          controller.add(messages);
        });
    controller.onCancel = () {
      subscription.cancel();
    };
    return controller.stream;
  }

  @override
  Stream<List<ChatModel>> getAllChatsStream() {
    final controller = StreamController<List<ChatModel>>();

    final subscription = _firestore
        .collection('chats') // todo replace with constants
        .orderBy('updatedAt', descending: true)
        .limit(50)
        .snapshots()
        .listen((snapshot) {
          final List<ChatModel> allChats = [];
          for (var doc in snapshot.docs) {
            allChats.add(ChatModel.fromMapAndId(doc.id, doc.data()));
          }
          controller.add(allChats);
        });

    controller.onCancel = () {
      subscription.cancel();
    };
    return controller.stream;
  }
}
