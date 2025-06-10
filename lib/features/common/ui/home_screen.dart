import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../auth/ui/auth_screen.dart';
import '../../auth/ui/auth_viewmodel.dart';
import '../../chat/ui/chat_screen.dart';
import '../../explore/ui/explore_screen.dart';
import '../../profile/ui/profile_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {

    String? errorAuthMessage = context.watch<AuthViewModel>().errorAuthMessage;
    /* Perhaps (?) no need for 'watch' for 'loggedIn' because errorAuthMessage is already watching. So we can avoid unnecessary rebuild without two 'watch' calls. */
    bool loggedIn = context.read<AuthViewModel>().loggedIn;

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
        child:
          switch (_selectedIndex) {
            0 => const ExploreScreen(),
            1 => const ProfileScreen(),
            2 => const ChatScreen(),
            _ => const Text('Unknown Screen'),
          },
      ),

      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.explore), label: 'Explore'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          BottomNavigationBarItem(icon: Icon(ChatScreen.icon), label: ChatScreen.title),
        ],
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),

    );
  }
}
