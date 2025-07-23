import 'package:uuid/uuid.dart';

import 'interest_model.dart';
import 'package:reach_skills/core/constants/strings.dart';

class SkillModel extends InterestModel {
  SkillModel({
    String id = '',
    super.title = '',
    super.description = '',
    super.tags = '',
    super.userId = '',
    super.userName = '',
  }) : super(interestType: InterestType.skill, id: id != '' ? id : Uuid().v4());

  /* Not necessary. The implementation of InterestModel.fromMap is enough */
  SkillModel.fromMap(Map<String, dynamic> map)
    : super(
        interestType: InterestType.skill,
        id:
            map[Str.INTEREST_FIELD_ID] ??
            (throw Exception(
              '${Str.excMessageNullId} ${Str.excMessageInterestModelFromMap}',
            )),
        title:
            map[Str.INTEREST_FIELD_TITLE] ??
            (throw Exception(
              '${Str.excMessageNullTitle} ${Str.excMessageInterestModelFromMap}',
            )),
        description: map[Str.INTEREST_FIELD_DESCRIPTION] ?? '',
        tags: map[Str.INTEREST_FIELD_TAGS] ?? '',
        userId:
            map[Str.INTEREST_FIELD_USER_ID] ??
            (throw Exception(
              '${Str.excMessageNullUserId} ${Str.excMessageInterestModelFromMap}',
            )),
        userName:
            map[Str.INTEREST_FIELD_USER_NAME] ??
            (throw Exception(
              '${Str.excMessageNullUserName} ${Str.excMessageInterestModelFromMap}',
            )),
      );

  @override
  Map<String, dynamic> toMap() {
    return {
      Str.INTEREST_FIELD_INTEREST_TYPE: interestType.name,
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
    /* Dart smart casts 'other' to ProfileModel after the previous 'is!' check.
     So, there's no need to reassign 'other' as 'typedOther'. */
    return interestType == typedOther.interestType &&
        id == typedOther.id &&
        title == typedOther.title &&
        description == typedOther.description &&
        tags == typedOther.tags &&
        userId == typedOther.userId &&
        userName == typedOther.userName;
  }

  @override
  int get hashCode =>
      Object.hash(interestType, id, title, description, tags, userId, userName);
}
