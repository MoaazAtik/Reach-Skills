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

  InterestType interestType;
  String id;
  String title;
  String description;
  String tags;
  String userId;
  String userName;

  // InterestModel fromMap(Map<String, dynamic> map);
  // factory InterestModel.fromMap(Map<String, dynamic> map);

  Map<String, dynamic> toMap();

  InterestModel copyWith(Map<String, dynamic> map);

  @override
  String toString();

  @override
  bool operator ==(Object other);

  @override
  int get hashCode => super.hashCode;
}
