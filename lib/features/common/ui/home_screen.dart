import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(

      appBar: AppBar(
        title: const Text('SkillSwap - Home'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
            },
          )
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
            ElevatedButton(
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
              },
              child: const Text('Sign Out'),
            )
          ],
        ),
      ),

    );
  }
}
