import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart' hide StreamProvider;
import 'package:flutter_riverpod/flutter_riverpod.dart'
// hide StreamProvider
;
import 'package:skill_swap/features/auth/ui/auth_viewmodel.dart';

import '../../home/ui/home_screen.dart';
import 'auth_screen.dart';

// final authStateProvider = StreamProvider<User?>((ref) {
//   return FirebaseAuth.instance.authStateChanges();
// });

// final authStateProvider = StreamProvider<User?>(
//   create: (context) => FirebaseAuth.instance.authStateChanges(),
//   initialData: null,
// );

// class AuthGate extends ConsumerWidget {
class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  // Widget build(BuildContext context, WidgetRef ref) {
  Widget build(BuildContext context) {
    // final authState = ref.watch(authStateProvider);
    // final authState = context.watch<AuthViewModel>().loggedIn;
    String? errorAuthMessage = context.watch<AuthViewModel>().errorAuthMessage;
    /* Perhaps (?) no need for 'watch' for 'loggedIn' because errorAuthMessage is already watching. So we can avoid unnecessary rebuild without two 'watch' calls. */
    bool loggedIn = context.read<AuthViewModel>().loggedIn;

    // authState.listen((event) {
    //   if (event != null) {
    //     print('User is logged in');
    //     HomeScreen();
    //   }
    //   else {
    //     print('User is logged out');
    //     AuthScreen();
    //   }
    // });

    if (errorAuthMessage != null) {
      return Center(child: Text('Error: $errorAuthMessage'));
    }

    if (loggedIn) {
      return HomeScreen();
    } else {
      return AuthScreen();
    }

    // return authState.when(
    //   data: (user) {
    //     if (user != null) {
    //       return HomeScreen();
    //     } else {
    //       return AuthScreen();
    //     }
    //   },
    //
    //   loading: () => const Center(child: CircularProgressIndicator()),
    //
    //   error: (e, _) => Center(child: Text('Error: $e')),
    // );
  }
}
