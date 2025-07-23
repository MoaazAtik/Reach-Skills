import '../../../core/constants/strings.dart';

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
      chatId:
          map[Str.MESSAGE_FIELD_CHAT_ID] ??
          (throw Exception(
            '${Str.excMessageNullChatId} ${Str.excMessageMessageModelFromMapAndId}',
          )),
      senderId:
          map[Str.MESSAGE_FIELD_SENDER_ID] ??
          (throw Exception(
            '${Str.excMessageNullSenderId} ${Str.excMessageMessageModelFromMapAndId}',
          )),
      senderName: map[Str.MESSAGE_FIELD_SENDER_NAME] ?? '',
      receiverId:
          map[Str.MESSAGE_FIELD_RECEIVER_ID] ??
          (throw Exception(
            '${Str.excMessageNullReceiverId} ${Str.excMessageMessageModelFromMapAndId}',
          )),
      receiverName: map[Str.MESSAGE_FIELD_RECEIVER_NAME] ?? '',
      createdAt: map[Str.MESSAGE_FIELD_CREATED_AT] ?? 0,
      updatedAt: map[Str.MESSAGE_FIELD_UPDATED_AT] ?? 0,
      content: map[Str.MESSAGE_FIELD_CONTENT] ?? '',
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
      Str.MESSAGE_FIELD_ID: id,
      Str.MESSAGE_FIELD_CHAT_ID: chatId,
      Str.MESSAGE_FIELD_SENDER_ID: senderId,
      Str.MESSAGE_FIELD_SENDER_NAME: senderName,
      Str.MESSAGE_FIELD_RECEIVER_ID: receiverId,
      Str.MESSAGE_FIELD_RECEIVER_NAME: receiverName,
      Str.MESSAGE_FIELD_CREATED_AT: createdAt,
      Str.MESSAGE_FIELD_UPDATED_AT: updatedAt,
      Str.MESSAGE_FIELD_CONTENT: content,
    };
  }

  MessageModel copyWith({
    String? id,
    String? chatId,
    String? senderId,
    String? senderName,
    String? receiverId,
    String? receiverName,
    int? createdAt,
    int? updatedAt,
    String? content,
  }) {
    return MessageModel(
      id: id ?? this.id,
      chatId: chatId ?? this.chatId,
      senderId: senderId ?? this.senderId,
      senderName: senderName ?? this.senderName,
      receiverId: receiverId ?? this.receiverId,
      receiverName: receiverName ?? this.receiverName,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      content: content ?? this.content,
    );
  }

  @override
  String toString() {
    return 'MessageModel {${Str.MESSAGE_FIELD_ID}: $id, ${Str.MESSAGE_FIELD_CHAT_ID}: $chatId, ${Str.MESSAGE_FIELD_SENDER_ID}: $senderId, ${Str.MESSAGE_FIELD_SENDER_NAME}: $senderName, ${Str.MESSAGE_FIELD_RECEIVER_ID}: $receiverId, ${Str.MESSAGE_FIELD_RECEIVER_NAME}: $receiverName, ${Str.MESSAGE_FIELD_CREATED_AT}: $createdAt, ${Str.MESSAGE_FIELD_UPDATED_AT}: $updatedAt, ${Str.MESSAGE_FIELD_CONTENT}: $content}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! MessageModel) return false;

    return id == other.id &&
        chatId == other.chatId &&
        senderId == other.senderId &&
        senderName == other.senderName &&
        receiverId == other.receiverId &&
        receiverName == other.receiverName &&
        createdAt == other.createdAt &&
        updatedAt == other.updatedAt;
  }

  @override
  int get hashCode => Object.hash(
    id,
    chatId,
    senderId,
    senderName,
    receiverId,
    receiverName,
    createdAt,
    updatedAt,
  );
}
