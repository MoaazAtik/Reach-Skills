import '../data/chat_model.dart';

abstract class ChatRepository {
  Future<void> saveChat(ChatModel chat);

  Future<ChatModel?> getChat(String id);

  Stream<List<ChatModel>> getAllChatsStream();
}
