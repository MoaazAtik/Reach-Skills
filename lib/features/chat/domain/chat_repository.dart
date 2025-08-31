import '../data/chat_model.dart';
import '../data/message_model.dart';

abstract class ChatRepository {
  Stream<List<ChatModel>>? get chatsStream;

  Stream<List<MessageModel>>? get messagesStream;

  void subscribeToChatsStream(String userId);

  void unsubscribeFromChatsStream();

  // from explore screen
  Future<String?> getChatIdOrCreateChat({
    required String personAId,
    required String personAName, // to create a chat
    required String personBId,
    required String personBName, // to create a chat
  });

  void subscribeToMessagesStream(String chatId, String userId);

  void unsubscribeFromMessagesStream();

  Future<void> sendMessage(MessageModel messageModel);

  Future<void> removeMessage(
    MessageModel message,
    MessageModel? olderMessage,
  );
}
