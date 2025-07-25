import '../../common/data/interest_model.dart';
import 'profile_model.dart';

abstract class ProfileRepository {
  Stream<List<InterestModel>>? get interestsStream;

  Stream<ProfileModel>? get profileStream;

  Future<String> updateProfile(ProfileModel profile);

  Future<String> removeInterest(InterestModel interest);

  Future<String> updateProfileTimestamp(String uid);

  void subscribeToProfileStream({required String uid, required String email});

  void unsubscribeFromProfileStream();

  void subscribeToInterestsStream({List<InterestType> interestTypes});

  void unsubscribeFromInterestsStream();
}
