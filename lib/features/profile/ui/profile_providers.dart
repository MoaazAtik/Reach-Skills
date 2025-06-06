import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/profile_repository.dart';

// Provides an instance of the repository
final profileRepositoryProvider = Provider<ProfileRepository>((ref) {
  return ProfileRepository();
});