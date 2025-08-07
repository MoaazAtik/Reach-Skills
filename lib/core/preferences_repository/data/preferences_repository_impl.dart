import 'package:reach_skills/core/preferences_repository/domain/preferences_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferencesRepositoryImpl extends PreferencesRepository {
  static const String _keyIsFirstInitialization = 'isFirstInitialization';
  // static const String _keyCurrentUserId = 'currentUserId';
  // static const String _keyCurrentUserName = 'currentUserName';

  @override
  Future<void> setIsFirstInitialization(bool value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(_keyIsFirstInitialization, value);
  }

  @override
  Future<bool> isFirstInitialization() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_keyIsFirstInitialization) ?? true;
  }

  // @override
  // Future<void> setCurrentUserIdAndName({required String currentUserId, required String currentUserName}) async {
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //   prefs.setString(_keyCurrentUserId, currentUserId);
  //   prefs.setString(_keyCurrentUserName, currentUserName);
  // }
  //
  // @override
  // Future<Map<String, String?>> getCurrentUserIdAndName() async {
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //   return {
  //     _keyCurrentUserId: prefs.getString(_keyCurrentUserId),
  //     _keyCurrentUserName: prefs.getString(_keyCurrentUserName),
  //   };
  // }
}
