import 'package:reach_skills/core/preferences_repository/domain/preferences_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferencesRepositoryImpl extends PreferencesRepository {
  static const String _keyIsFirstInitialization = 'isFirstInitialization';

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

  /*
  static final PreferencesRepositoryImpl _singleton = PreferencesRepositoryImpl._internal();

  factory PreferencesRepositoryImpl() {
    return _singleton;
  }

  PreferencesRepositoryImpl._internal();

  static PreferencesRepositoryImpl get instance => _singleton;

  late final SharedPreferences _sharedPreferences ;
  static SharedPreferences get sharedPreferences => _sharedPreferences;
  */
}
