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
}
