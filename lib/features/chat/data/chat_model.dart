import '../domain/chat_entity.dart';
import 'message_model.dart';

class ChatModel {
  final String id;
  final String senderId;
  final String senderName;
  final String receiverId;
  final String receiverName;
  final int createdAt;
  final int updatedAt;
  final List<MessageModel> messages;

  ChatModel({
    required this.id,
    required this.senderId,
    required this.senderName,
    required this.receiverId,
    required this.receiverName,
    required this.createdAt,
    required this.updatedAt,
    required this.messages,
  });

  factory ChatModel.withEntity(ChatEntity entity, List<MessageModel> messages) {
    return ChatModel(
      id: entity.id,
      senderId: entity.senderId,
      senderName: entity.senderName,
      receiverId: entity.receiverId,
      receiverName: entity.receiverName,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
      messages: messages,
    );
  }

  ChatEntity toEntity() {
    return ChatEntity(
      id: id,
      senderId: senderId,
      senderName: senderName,
      receiverId: receiverId,
      receiverName: receiverName,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}
