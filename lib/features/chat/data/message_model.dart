class MessageModel {
  final String id;
  final String chatId;

  /* Needed to ease load of all messages whether the current user is sender or receiver. */
  final String senderId;
  final String senderName;
  final String receiverId;
  final String receiverName;
  final int createdAt;
  final int updatedAt;
  final String content;

  static const String COLLECTION_NAME = 'messages';
  static const String FIELD_ID = 'id';
  static const String FIELD_CHAT_ID = 'chatId';
  static const String FIELD_SENDER_ID = 'senderId';
  static const String FIELD_SENDER_NAME = 'senderName';
  static const String FIELD_RECEIVER_ID = 'receiverId';
  static const String FIELD_RECEIVER_NAME = 'receiverName';
  static const String FIELD_CREATED_AT = 'createdAt';
  static const String FIELD_UPDATED_AT = 'updatedAt';
  static const String FIELD_CONTENT = 'content';

  MessageModel({
    this.id = '',
    this.chatId = '',
    this.senderId = '',
    this.senderName = '',
    this.receiverId = '',
    this.receiverName = '',
    this.createdAt = 0,
    this.updatedAt = 0,
    this.content = '',
  });

  factory MessageModel.fromMapAndId(String id, Map<String, dynamic> map) {
    return MessageModel(
      id: id,
      chatId: map[FIELD_CHAT_ID],
      senderId: map[FIELD_SENDER_ID],
      senderName: map[FIELD_SENDER_NAME],
      receiverId: map[FIELD_RECEIVER_ID],
      receiverName: map[FIELD_RECEIVER_NAME],
      createdAt: map[FIELD_CREATED_AT],
      updatedAt: map[FIELD_UPDATED_AT],
      content: map[FIELD_CONTENT],
    );
  }

  factory MessageModel.toBeStored({
    required String chatId,
    required String senderId,
    required String senderName,
    required String receiverId,
    required String receiverName,
    required String content,
  }) {
    return MessageModel(
      // no passed id. Firebase will generate one.
      chatId: chatId,
      senderId: senderId,
      senderName: senderName,
      receiverId: receiverId,
      receiverName: receiverName,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      updatedAt: DateTime.now().millisecondsSinceEpoch,
      content: content,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      FIELD_ID: id,
      FIELD_CHAT_ID: chatId,
      FIELD_SENDER_ID: senderId,
      FIELD_SENDER_NAME: senderName,
      FIELD_RECEIVER_ID: receiverId,
      FIELD_RECEIVER_NAME: receiverName,
      FIELD_CREATED_AT: createdAt,
      FIELD_UPDATED_AT: updatedAt,
      FIELD_CONTENT: content,
    };
  }
}
