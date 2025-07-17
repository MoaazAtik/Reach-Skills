import 'interest_model.dart';
import 'package:reach_skills/core/constants/strings.dart';

class SkillModel extends InterestModel {
  SkillModel({
    super.id = '',
    super.title = '',
    super.description = '',
    super.tags = '',
    super.userId = '',
    super.userName = '',
  }) : super(interestType: InterestType.skill);

  /* Not necessary. The implementation of InterestModel.fromMap is enough */
  SkillModel.fromMap(Map<String, dynamic> map)
    : super(
        interestType: InterestType.skill,
        id: map[Str.INTEREST_FIELD_ID],
        title: map[Str.INTEREST_FIELD_TITLE],
        description: map[Str.INTEREST_FIELD_DESCRIPTION],
        tags: map[Str.INTEREST_FIELD_TAGS],
        userId: map[Str.INTEREST_FIELD_USER_ID],
        userName: map[Str.INTEREST_FIELD_USER_NAME],
      );

  @override
  Map<String, dynamic> toMap() {
    return {
      Str.INTEREST_FIELD_INTEREST_TYPE: interestType,
      Str.INTEREST_FIELD_ID: id,
      Str.INTEREST_FIELD_TITLE: title,
      Str.INTEREST_FIELD_DESCRIPTION: description,
      Str.INTEREST_FIELD_TAGS: tags,
      Str.INTEREST_FIELD_USER_ID: userId,
      Str.INTEREST_FIELD_USER_NAME: userName,
    };
  }

  @override
  InterestModel copyWith(Map<String, dynamic> map) {
    return SkillModel(
      id: map[Str.INTEREST_FIELD_ID] ?? id,
      title: map[Str.INTEREST_FIELD_TITLE] ?? title,
      description: map[Str.INTEREST_FIELD_DESCRIPTION] ?? description,
      tags: map[Str.INTEREST_FIELD_TAGS] ?? tags,
      userId: map[Str.INTEREST_FIELD_USER_ID] ?? userId,
      userName: map[Str.INTEREST_FIELD_USER_NAME] ?? userName,
    );
  }

  @override
  String toString() {
    return 'SkillModel {${Str.INTEREST_FIELD_INTEREST_TYPE}: $interestType, ${Str.INTEREST_FIELD_ID}: $id, ${Str.INTEREST_FIELD_TITLE}: $title, ${Str.INTEREST_FIELD_DESCRIPTION}: $description, ${Str.INTEREST_FIELD_TAGS}: $tags, ${Str.INTEREST_FIELD_USER_ID}: $userId, ${Str.INTEREST_FIELD_USER_NAME}: $userName}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! SkillModel) return false;

    final SkillModel typedOther = other;
    return interestType == typedOther.interestType &&
        id == typedOther.id &&
        title == typedOther.title &&
        description == typedOther.description &&
        tags == typedOther.tags &&
        userId == typedOther.userId &&
        userName == typedOther.userName;
  }
}
