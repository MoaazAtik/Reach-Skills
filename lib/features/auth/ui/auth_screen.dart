import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../common/ui/home_screen.dart';
import 'auth_viewmodel.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authViewModel = context.watch<AuthViewModel>();
    final isLoggedIn = authViewModel.isLoggedIn;

    final authError = authViewModel.authError;

    if (authError != null) {
      return Center(child: Text('Error: $authError'));
    }

    if (isLoggedIn) {
      return HomeScreen();
    } else {
      return SignInScreen(
        providers: [
          EmailAuthProvider(),
        ],
      );
    }
  }
}