import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/strings.dart';
import 'auth_viewmodel.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authViewModel = context.watch<AuthViewModel>();
    // Todo perhaps remove this isLoggedIn
    // and use the one passed to the widget by routing
    final isLoggedIn = authViewModel.isLoggedIn;

    final authError = authViewModel.authError;

    if (authError != null) {
      return Center(child: Text('${Str.error}: $authError'));
    }

    return SignInScreen(providers: [EmailAuthProvider()]);
  }
}
