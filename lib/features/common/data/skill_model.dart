import 'interest_model.dart';

class SkillModel extends InterestModel {
  SkillModel({required super.title, required super.uid, required super.userName})
    : super(interestType: InterestType.skill);
}
