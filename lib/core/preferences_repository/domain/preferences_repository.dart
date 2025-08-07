abstract class PreferencesRepository {
  Future<void> setIsFirstInitialization(bool value);

  Future<bool> isFirstInitialization();

  // Todo remove these and their implementation. Perhaps I'll implement them in later updates. They'll need Synchronization between the Local and Remote databases for when data is updated on different devices.
  // Future<void> setCurrentUserIdAndName({required String currentUserId, required String currentUserName});
  //
  // Future<Map<String, String?>> getCurrentUserIdAndName();
}
