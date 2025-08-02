import '../../common/data/interest_model.dart';
import 'profile_model.dart';

abstract class ProfileRepository {
  Stream<List<InterestModel>>? get interestsStream;

  Stream<ProfileModel>? get profileStream;

  List<InterestModel?>? get interestsHistory;

  Future<String> updateProfile(ProfileModel profile);

  Future<String> removeInterest(InterestModel interest);

  Future<String> updateProfileTimestamp(String uid);

  void subscribeToProfileStream({required String uid, required String email});

  Future<void> unsubscribeFromProfileStream();

  Future<ProfileModel?> getProfile(String uid);

  void subscribeToInterestsStream({List<InterestType> interestTypes});

  void unsubscribeFromInterestsStream();

  Stream<List<InterestModel>> getInterestsStreamWithInitialValue();

  void updateInterestsHistory(InterestModel? interest);
}
