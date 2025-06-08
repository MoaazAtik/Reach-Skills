import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../home/ui/home_screen.dart';
import 'auth_viewmodel.dart';

class AuthScreen extends StatelessWidget { // todo rename AuthScreen to SignInScreen

  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {

    String? errorAuthMessage = context.watch<AuthViewModel>().errorAuthMessage;
    /* Perhaps (?) no need for 'watch' for 'loggedIn' because errorAuthMessage is already watching. So we can avoid unnecessary rebuild without two 'watch' calls. */
    bool loggedIn = context.read<AuthViewModel>().loggedIn;

    if (errorAuthMessage != null) {
      return Center(child: Text('Error: $errorAuthMessage'));
    }

    if (loggedIn) {
      return HomeScreen();
    } else {
      // return AuthScreen();
      return SignInScreen(
        providers: [
          EmailAuthProvider(),
        ],
      );
    }
  }

}