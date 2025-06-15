class ChatModel {
  final String id;
  final String person1Id;
  final String person1Name;
  final String person2Id;
  final String person2Name;
  final int createdAt;
  final int updatedAt;

  static const String COLLECTION_NAME = 'chats';
  static const String FIELD_ID = 'id';
  static const String FIELD_PERSON1_ID = 'person1Id';
  static const String FIELD_PERSON1_NAME = 'person1Name';
  static const String FIELD_PERSON2_ID = 'person2Id';
  static const String FIELD_PERSON2_NAME = 'person2Name';
  static const String FIELD_CREATED_AT = 'createdAt';
  static const String FIELD_UPDATED_AT = 'updatedAt';

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
      person1Id: map[FIELD_PERSON1_ID],
      person1Name: map[FIELD_PERSON1_NAME],
      person2Id: map[FIELD_PERSON2_ID],
      person2Name: map[FIELD_PERSON2_NAME],
      createdAt: map[FIELD_CREATED_AT],
      updatedAt: map[FIELD_UPDATED_AT],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      FIELD_ID: id,
      FIELD_PERSON1_ID: person1Id,
      FIELD_PERSON1_NAME: person1Name,
      FIELD_PERSON2_ID: person2Id,
      FIELD_PERSON2_NAME: person2Name,
      FIELD_CREATED_AT: createdAt,
      FIELD_UPDATED_AT: updatedAt,
    };
  }
}
