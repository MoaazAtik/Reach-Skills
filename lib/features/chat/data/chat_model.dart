import 'message_model.dart';

class ChatModel {
  final String id;
  final MessageModel message;
  final int lastUpdated;

  ChatModel({
    required this.id,
    required this.message,
    required this.lastUpdated,
  });

  factory ChatModel.fromMap(Map<String, dynamic> map) {
    return ChatModel(
      id: map['id'] ?? '',
      message: MessageModel.fromMap(map['message']),
      lastUpdated: map['lastUpdated'].toInt() ?? 0,
    );
  }

  Map<String, dynamic> toMap() {
    return {'id': id, 'message': message.toMap(), 'lastUpdated': lastUpdated};
  }
}
