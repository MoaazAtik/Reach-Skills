import '../../common/data/interest_model.dart';
import 'profile_model.dart';

abstract class ProfileRepository {
  Future<void> saveProfile(ProfileModel profile);

  Future<ProfileModel?> getProfile(String uid);

  Future<List<InterestModel>> getInterests(List<InterestType> interestTypes);
}
