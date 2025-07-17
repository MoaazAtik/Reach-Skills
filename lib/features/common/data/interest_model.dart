import '../../../core/constants/strings.dart';

enum InterestType { skill, wish }

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
        interestType: map[Str.INTEREST_FIELD_INTEREST_TYPE],
        id: map[Str.INTEREST_FIELD_ID],
        title: map[Str.INTEREST_FIELD_TITLE],
        description: map[Str.INTEREST_FIELD_DESCRIPTION],
        tags: map[Str.INTEREST_FIELD_TAGS],
        userId: map[Str.INTEREST_FIELD_USER_ID],
        userName: map[Str.INTEREST_FIELD_USER_NAME],
      );

  Map<String, dynamic> toMap();

  InterestModel copyWith(Map<String, dynamic> map);

  @override
  String toString();

  @override
  bool operator ==(Object other);

  @override
  int get hashCode => super.hashCode;
}
