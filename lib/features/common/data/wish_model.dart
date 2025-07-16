import '../../../core/constants/strings.dart';
import 'interest_model.dart';

class WishModel extends InterestModel {
  WishModel({
    super.id = '',
    super.title = '',
    super.description = '',
    super.tags = '',
    super.userId = '',
    super.userName = '',
  }) : super(interestType: InterestType.wish);

  factory WishModel.fromMap(Map<String, dynamic> map) {
    return WishModel(
      id: map[Str.INTEREST_FIELD_ID],
      title: map[Str.INTEREST_FIELD_TITLE],
      description: map[Str.INTEREST_FIELD_DESCRIPTION],
      tags: map[Str.INTEREST_FIELD_TAGS],
      userId: map[Str.INTEREST_FIELD_USER_ID],
      userName: map[Str.INTEREST_FIELD_USER_NAME],
    );
  }

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
}
