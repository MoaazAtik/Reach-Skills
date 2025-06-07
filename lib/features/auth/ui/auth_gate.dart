import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../home/ui/home_screen.dart';
import 'auth_screen.dart';
import 'auth_viewmodel.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

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
      return AuthScreen();
    }
  }
}
