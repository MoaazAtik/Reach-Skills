import '../data/chat_model.dart';
import '../data/message_model.dart';

abstract class ChatRepository {
  // from explore screen
  void sendMessage({
    required String senderId,
    required String senderName,
    required String receiverId,
    required String receiverName,
    required String content,
  });

  // from messages screen
  Future<void> sendMessageWithChatId({
    required String chatId,
    required String content,
  });

  Stream<List<ChatModel>> getAllChatsStream();

  Stream<List<MessageModel>> getMessagesStream(String chatId);
}
