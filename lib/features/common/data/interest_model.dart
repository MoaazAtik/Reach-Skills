enum InterestType { skill, wish }

abstract class InterestModel {
  InterestModel({
    required this.interestType,
    required this.title,
    required this.uid,
  });

  InterestType interestType;
  String title;
  String uid;
}
