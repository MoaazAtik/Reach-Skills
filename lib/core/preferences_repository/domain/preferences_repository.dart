abstract class PreferencesRepository {
  Future<void> setIsFirstInitialization(bool value);

  Future<bool> isFirstInitialization();
}
