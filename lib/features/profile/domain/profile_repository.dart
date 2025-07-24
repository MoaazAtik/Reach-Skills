import '../../common/data/interest_model.dart';
import 'profile_model.dart';

abstract class ProfileRepository {
  Stream<List<InterestModel>>? get interestsStream;

  Stream<ProfileModel>? get profileStream;

  Future<String> saveProfile(ProfileModel profile);

  Future<ProfileModel?> getProfile(String uid);

  Future<String> removeInterest(InterestModel interest);

  Future<String> updateProfileTimestamp(String uid);

  void subscribeToProfileStream({required String uid});

  void unsubscribeFromProfileStream();

  void subscribeToInterestsStream({List<InterestType> interestTypes});

  void unsubscribeFromInterestsStream();
}
