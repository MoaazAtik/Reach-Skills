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

  factory MessageModel.fromChatIdAndContent({
    required String chatId,
    required String content,
  }) {
    return MessageModel(
      id: '',
      chatId: chatId,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      updatedAt: DateTime.now().millisecondsSinceEpoch,
      content: content,
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
