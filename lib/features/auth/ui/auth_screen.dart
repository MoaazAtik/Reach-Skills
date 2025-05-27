import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';

class AuthScreen extends StatelessWidget {

  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return SignInScreen(
      providers: [
        EmailAuthProvider(),
      ],
    );
  }

}