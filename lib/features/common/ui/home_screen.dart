import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../auth/ui/auth_screen.dart';
import '../../auth/ui/auth_viewmodel.dart';
import '../../profile/ui/profile_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {

    String? errorAuthMessage = context.watch<AuthViewModel>().errorAuthMessage;
    /* Perhaps (?) no need for 'watch' for 'loggedIn' because errorAuthMessage is already watching. So we can avoid unnecessary rebuild without two 'watch' calls. */
    bool loggedIn = context.read<AuthViewModel>().loggedIn;
    User? user = context.read<AuthViewModel>().currentUser;

    return Scaffold(

      appBar: AppBar(
        title: const Text('SkillSwap - Home'),
        actions: [

          if (errorAuthMessage != null)
            Text('Error: $errorAuthMessage'),

          if (loggedIn)
            const Text('Logged in'),

          if (!loggedIn)
            const Text('Not logged in'),

          if (loggedIn)
            IconButton(
              icon: const Icon(Icons.logout),
              onPressed: context.read<AuthViewModel>().signOut,
            ),

          if (!loggedIn)
            IconButton(
              icon: const Icon(Icons.login),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const AuthScreen()),
                );
              }
            ),

        ],
      ),

      body: Center(
        child: user == null
            ? Text('No user info available.')
            : Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Logged in as:'),
            const SizedBox(height: 8),
            Text(user.displayName ?? 'No display name'),
            Text(user.email ?? 'No email'),
            const SizedBox(height: 16),
            TextButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => const ProfileScreen()),
                  );
                },
                child: const Text('Edit Profile'),
            ),
            ElevatedButton(
              onPressed: context.read<AuthViewModel>().signOut,
              child: const Text('Sign Out'),
            )
          ],
        ),
      ),

    );
  }
}
