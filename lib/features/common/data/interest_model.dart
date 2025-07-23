import '../../../core/constants/strings.dart';

enum InterestType {
  skill(Str.skill),
  wish(Str.wish);

  const InterestType(this.asTitle);

  final String asTitle;
}

abstract class InterestModel {
  InterestModel({
    required this.interestType,
    required this.id,
    required this.title,
    required this.description,
    required this.tags,
    required this.userId,
    required this.userName,
  });

  final InterestType interestType;
  final String id;
  final String title;
  final String description;
  final String tags;
  final String userId;
  final String userName;

  InterestModel.fromMap(Map<String, dynamic> map)
    : this(
        interestType:
            map[Str.INTEREST_FIELD_INTEREST_TYPE] ?? InterestType.skill,
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

  Map<String, dynamic> toMap();

  InterestModel copyWith(Map<String, dynamic> map);

  @override
  String toString();

  @override
  bool operator ==(Object other);

  @override
  int get hashCode;
}
