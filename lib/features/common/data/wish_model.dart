import 'package:uuid/uuid.dart';

import '../../../core/constants/strings.dart';
import 'interest_model.dart';

class WishModel extends InterestModel {
  WishModel({
    String id = '',
    super.title = '',
    super.description = '',
    super.tags = '',
    super.userId = '',
    super.userName = '',
  }) : super(interestType: InterestType.wish, id: id != '' ? id : Uuid().v4());

  /* Not necessary. The implementation of InterestModel.fromMap is enough */
  WishModel.fromMap(Map<String, dynamic> map)
    : super(
        interestType: InterestType.wish,
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
    return WishModel(
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
    return 'WishModel {${Str.INTEREST_FIELD_INTEREST_TYPE}: $interestType, ${Str.INTEREST_FIELD_ID}: $id, ${Str.INTEREST_FIELD_TITLE}: $title, ${Str.INTEREST_FIELD_DESCRIPTION}: $description, ${Str.INTEREST_FIELD_TAGS}: $tags, ${Str.INTEREST_FIELD_USER_ID}: $userId, ${Str.INTEREST_FIELD_USER_NAME}: $userName}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! WishModel) return false;

    final WishModel typedOther = other;
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
