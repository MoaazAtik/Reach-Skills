class MessageModel {
  final String id;
  final String chatId;
  final int createdAt;
  final int updatedAt;
  final String content;

  MessageModel({
    required this.id,
    required this.chatId,
    required this.createdAt,
    required this.updatedAt,
    required this.content,
  });

  factory MessageModel.fromMapAndId(String id, Map<String, dynamic> map) {
    return MessageModel(
      id: id,
      chatId: map['chatId'] ?? '',
      createdAt: map['createdAt'].toInt() ?? 0,
      updatedAt: map['updatedAt'].toInt() ?? 0,
      content: map['content'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'chatId': chatId,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'content': content,
    };
  }
}
