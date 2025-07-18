import '../data/chat_model.dart';
import '../data/message_model.dart';

abstract class ChatRepository {
  Stream<List<ChatModel>>? get chatsStream;

  Stream<List<MessageModel>>? get messagesStream;

  void subscribeToChatsStream();

  void unsubscribeFromChatsStream();

  // from explore screen
  Future<String?> getChatIdOrCreateChat({
    required String personAId,
    required String personAName, // to create a chat
    required String personBId,
    required String personBName, // to create a chat
  });

  void subscribeToMessagesStream(String chatId);

  void unsubscribeFromMessagesStream();

  Future<void> sendMessage(MessageModel messageModel);
}
