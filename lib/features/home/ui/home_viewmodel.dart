import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

import '../domain/home_repository.dart';

class HomeViewModel extends ChangeNotifier {
  HomeViewModel({required HomeRepository homeRepository})
    : _homeRepository = homeRepository {
    init();
  }

  final HomeRepository _homeRepository;

  User? _currentUser;

  User? get currentUser => _currentUser;

  Future<void> init() async {
    _currentUser = _homeRepository.getCurrentUser();
  }

  Future<void> signOut() async {
    await _homeRepository.signOut();
  }
}
