import '../../../core/constants/strings.dart';

class ChatModel {
  final String id;
  final String person1Id;
  final String person1Name;
  final String person2Id;
  final String person2Name;
  final int createdAt;
  final int updatedAt;

  ChatModel({
    this.id = '',
    this.person1Id = '',
    this.person1Name = '',
    this.person2Id = '',
    this.person2Name = '',
    this.createdAt = 0,
    this.updatedAt = 0,
  });

  factory ChatModel.fromMapAndId(String id, Map<String, dynamic> map) {
    return ChatModel(
      id: id,
      person1Id: map[Str.CHAT_FIELD_PERSON1_ID],
      person1Name: map[Str.CHAT_FIELD_PERSON1_NAME],
      person2Id: map[Str.CHAT_FIELD_PERSON2_ID],
      person2Name: map[Str.CHAT_FIELD_PERSON2_NAME],
      createdAt: map[Str.CHAT_FIELD_CREATED_AT],
      updatedAt: map[Str.CHAT_FIELD_UPDATED_AT],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      Str.CHAT_FIELD_ID: id,
      Str.CHAT_FIELD_PERSON1_ID: person1Id,
      Str.CHAT_FIELD_PERSON1_NAME: person1Name,
      Str.CHAT_FIELD_PERSON2_ID: person2Id,
      Str.CHAT_FIELD_PERSON2_NAME: person2Name,
      Str.CHAT_FIELD_CREATED_AT: createdAt,
      Str.CHAT_FIELD_UPDATED_AT: updatedAt,
    };
  }
}
