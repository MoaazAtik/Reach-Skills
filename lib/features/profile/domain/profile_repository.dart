import '../../common/data/interest_model.dart';
import 'profile_model.dart';

abstract class ProfileRepository {
  Stream<List<InterestModel>>? get interestsStream;

  Future<void> saveProfile(ProfileModel profile);

  Future<ProfileModel?> getProfile(String uid);

  void subscribeToInterestsStream({List<InterestType> interestTypes});

  void unsubscribeFromInterestsStream();
}
