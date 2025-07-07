import 'interest_model.dart';

class SkillModel extends InterestModel {
  SkillModel({
    super.id = '',
    super.title = '',
    super.description = '',
    super.tags = '',
    super.userId = '',
    super.userName = '',
  }) : super(interestType: InterestType.skill);
}
