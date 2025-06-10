import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../domain/chat_repository.dart';
import 'chat_model.dart';
import 'message_model.dart';

class ChatRepositoryImpl extends ChatRepository {
  final _firestore = FirebaseFirestore.instance;

  Future<String?> getChatId(
    String senderId,
    String senderName,
    String receiverId,
    String receiverName,
  ) async {
    late String? chatId;

    await _firestore
        .collection('chats')
        .where('senderId', isEqualTo: senderId)
        .where('receiverId', isEqualTo: receiverId)
        .get()
        .then((snapshot) {
          if (snapshot.docs.isNotEmpty) {
            chatId = snapshot.docs.first.id;
          }
        });
    if (chatId != null) {
      return chatId;
    }

    await createChat(senderId, senderName, receiverId, receiverName).then((
      value,
    ) {
      chatId = value;
    });

    if (chatId != null) {
      return chatId;
    } else {
      throw Exception('Could not get chat id.');
    }
  }

  Future<String?> createChat(
    String senderId,
    String senderName,
    String receiverId,
    String receiverName,
  ) async {
    String? chatId;

    await _firestore
        .collection('chats')
        .add({
          'senderId': senderId,
          'senderName': senderName,
          'receiverId': receiverId,
          'receiverName': receiverName,
          'createdAt': DateTime.now().millisecondsSinceEpoch,
          'updatedAt': DateTime.now().millisecondsSinceEpoch,
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
  Future<void> reachAndSendMessage({
    required String senderId,
    required String senderName,
    required String receiverId,
    required String receiverName,
    required String content,
  }) async {
    late String? chatId;

    await getChatId(senderId, senderName, receiverId, receiverName).then((
      value,
    ) {
      chatId = value;
    });

    if (chatId != null) {
      sendMessageViaMessageModel(
        messageModel: MessageModel.fromChatIdAndContent(
          chatId: chatId!,
          content: content,
        ),
      );
    } else {
      throw Exception('Chat not found');
    }
  }

  @override
  Future<void> sendMessageViaMessageModel({
    required MessageModel messageModel,
  }) async {
    final messageModelMap = messageModel.toMap();
    final newDocRef = _firestore.collection('chats').doc();
    messageModelMap['id'] = newDocRef.id;
    await newDocRef.set(messageModelMap);
  }

  @override
  Stream<List<ChatModel>> getAllChatsStream() {
    final controller = StreamController<List<ChatModel>>();

    final subscription = _firestore
        .collection('chats')
        .orderBy('updatedAt', descending: true)
        .limit(30)
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

  @override
  Stream<List<MessageModel>> getMessagesStream(String chatId) {
    final controller = StreamController<List<MessageModel>>();
    final subscription = _firestore
        .collection('messages')
        .where('chatId', isEqualTo: chatId)
        // .orderBy('updatedAt', descending: true)
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
}
