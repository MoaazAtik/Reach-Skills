class ChatEntity {
  final String id;
  final String senderId;
  final String senderName;
  final String receiverId;
  final String receiverName;
  final int createdAt;
  final int updatedAt;

  // Unlike ChatModel, ChatEntity does not have a list of messages.

  ChatEntity({
    required this.id,
    required this.senderId,
    required this.senderName,
    required this.receiverId,
    required this.receiverName,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ChatEntity.fromMap(Map<String, dynamic> map) {
    return ChatEntity(
      id: map['id'] ?? '',
      senderId: map['senderId'] ?? '',
      senderName: map['senderName'] ?? '',
      receiverId: map['receiverId'] ?? '',
      receiverName: map['receiverName'] ?? '',
      createdAt: map['createdAt'].toInt() ?? 0,
      updatedAt: map['updatedAt'].toInt() ?? 0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'senderId': senderId,
      'senderName': senderName,
      'receiverId': receiverId,
      'receiverName': receiverName,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }
}
