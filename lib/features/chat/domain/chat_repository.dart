import '../data/chat_model.dart';
import '../data/message_model.dart';

abstract class ChatRepository {
  // from explore screen
  Future<String?> getChatIdOrCreateChat({
    required String personAId,
    required String personAName, // to create a chat
    required String personBId,
    required String personBName, // to create a chat
  });

  // messagesStream2 can be declared in the ChatRepositoryImpl only,
  // or in the ChatRepository.
  Stream<List<MessageModel>>? messagesStream2;

  // Stream:
  void subscribeToMessagesAsStream(String chatId);

  // ValueNotifier:
  void subscribeToMessagesAsValueNotifier(String chatId);

  Stream<List<MessageModel>> getMessagesStream(String chatId);

  Future<void> sendMessage(MessageModel messageModel);

  Stream<List<ChatModel>> getAllChatsStream();
}
