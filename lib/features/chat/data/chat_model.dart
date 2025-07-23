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
      person1Id:
          map[Str.CHAT_FIELD_PERSON1_ID] ??
          (throw Exception(
            '${Str.excMessageNullPerson1Id} ${Str.excMessageChatModelFromMapAndId}',
          )),
      person1Name: map[Str.CHAT_FIELD_PERSON1_NAME] ?? '',
      person2Id:
          map[Str.CHAT_FIELD_PERSON2_ID] ??
          (throw Exception(
            '${Str.excMessageNullPerson2Id} ${Str.excMessageChatModelFromMapAndId}',
          )),
      person2Name: map[Str.CHAT_FIELD_PERSON2_NAME] ?? '',
      createdAt: map[Str.CHAT_FIELD_CREATED_AT] ?? 0,
      updatedAt: map[Str.CHAT_FIELD_UPDATED_AT] ?? 0,
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

  ChatModel copyWith({
    String? id,
    String? person1Id,
    String? person1Name,
    String? person2Id,
    String? person2Name,
    int? createdAt,
    int? updatedAt,
  }) {
    return ChatModel(
      id: id ?? this.id,
      person1Id: person1Id ?? this.person1Id,
      person1Name: person1Name ?? this.person1Name,
      person2Id: person2Id ?? this.person2Id,
      person2Name: person2Name ?? this.person2Name,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  String toString() {
    return 'ChatModel {${Str.CHAT_FIELD_ID}: $id, ${Str.CHAT_FIELD_PERSON1_ID}: $person1Id, ${Str.CHAT_FIELD_PERSON1_NAME}: $person1Name, ${Str.CHAT_FIELD_PERSON2_ID}: $person2Id, ${Str.CHAT_FIELD_PERSON2_NAME}: $person2Name, ${Str.CHAT_FIELD_CREATED_AT}: $createdAt, ${Str.CHAT_FIELD_UPDATED_AT}: $updatedAt}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! ChatModel) return false;

    return id == other.id &&
        person1Id == other.person1Id &&
        person1Name == other.person1Name &&
        person2Id == other.person2Id &&
        person2Name == other.person2Name &&
        createdAt == other.createdAt &&
        updatedAt == other.updatedAt;
  }

  @override
  int get hashCode => Object.hash(
    id,
    person1Id,
    person1Name,
    person2Id,
    person2Name,
    createdAt,
    updatedAt,
  );
}
