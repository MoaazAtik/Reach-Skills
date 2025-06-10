import '../data/chat_model.dart';
import '../data/message_model.dart';

abstract class ChatRepository {
  // from explore screen
  Future<void> reachAndSendMessage({
    required String senderId,
    required String senderName,
    required String receiverId,
    required String receiverName,
    required String content,
  });

  // from messages screen
  Future<void> sendMessageViaMessageModel({
    required MessageModel messageModel,
  });

  Stream<List<ChatModel>> getAllChatsStream();

  Stream<List<MessageModel>> getMessagesStream(String chatId);
}
