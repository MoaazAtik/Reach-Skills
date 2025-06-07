import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../profile/ui/edit_profile_screen.dart';
import 'home_viewmodel.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final user = context.select((HomeViewModel vm) => vm.currentUser);

    return Scaffold(

      appBar: AppBar(
        title: const Text('SkillSwap - Home'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: context.read<HomeViewModel>().signOut,
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
            TextButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => const EditProfileScreen()),
                  );
                },
                child: const Text('Edit Profile'),
            ),
            ElevatedButton(
              onPressed: context.read<HomeViewModel>().signOut,
              child: const Text('Sign Out'),
            )
          ],
        ),
      ),

    );
  }
}
