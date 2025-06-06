import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../common/ui/home_screen.dart';
import 'auth_screen.dart';


final authStateProvider = StreamProvider<User?>((ref) {
  return FirebaseAuth.instance.authStateChanges();
});


class AuthGate extends ConsumerWidget {

  const AuthGate({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final authState = ref.watch(authStateProvider);

    return authState.when(

      data: (user) {
        if (user != null) {
          return HomeScreen();
        } else {
          return AuthScreen();
        }
      },

      loading: () => const Center(child: CircularProgressIndicator()),

      error: (e, _) => Center(child: Text('Error: $e')),
    );
  }

}