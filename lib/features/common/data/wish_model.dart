import 'interest_model.dart';

class WishModel extends InterestModel {
  WishModel({required super.title, required super.uid, required super.userName})
    : super(interestType: InterestType.wish);
}
