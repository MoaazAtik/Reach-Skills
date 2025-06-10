enum InterestType { skill, wish }

abstract class InterestModel {
  InterestModel({
    required this.interestType,
    required this.title,
    required this.uid,
    required this.userName,
  });

  InterestType interestType;
  String title;
  String uid;
  String userName;
}
