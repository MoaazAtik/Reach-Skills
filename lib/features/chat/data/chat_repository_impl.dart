import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:skill_swap/features/chat/data/chat_model.dart';

import '../domain/chat_repository.dart';

class ChatRepositoryImpl extends ChatRepository {
  final _firestore = FirebaseFirestore.instance;

  @override
  Future<void> saveChat(ChatModel chat) async {
    await _firestore.collection('chats').doc(chat.id).set(chat.toMap());
  }

  @override
  Future<ChatModel?> getChat(String id) {
    // TODO: implement getChat
    throw UnimplementedError();
  }

  @override
  Stream<List<ChatModel>> getAllChatsStream() {
    final controller = StreamController<List<ChatModel>>();

    final subscription = _firestore
        .collection('chats')
        .orderBy('lastUpdated', descending: true)
        .limit(30)
        .snapshots()
        .listen((snapshot) {
          final List<ChatModel> allChats = [];
          for (var doc in snapshot.docs) {
            allChats.add(ChatModel.fromMap(doc.data()));
          }
          controller.add(allChats);
        });

    controller.onCancel = () {
      subscription.cancel();
    };
    return controller.stream;
  }
}
