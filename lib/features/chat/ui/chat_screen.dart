import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../auth/ui/auth_screen.dart';
import 'chat_viewmodel.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  static const routeName = '/chat';
  static const title = 'Chat';
  static const icon = Icons.chat;

  @override
  Widget build(BuildContext context) {
    final chatViewModel = context.watch<ChatViewModel>();
    final isLoggedIn = chatViewModel.isLoggedIn;
    final loading = chatViewModel.loading;
    final allChats = chatViewModel.allChats;

    if (!isLoggedIn) {
      return Column(
        children: [
          const SizedBox(height: 40),
          Text('No user info available.'),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () {
              Navigator.of(
                context,
              ).push(MaterialPageRoute(builder: (_) => const AuthScreen()));
            },
            child: const Text('Sign in'),
          ),
        ],
      );
    }

    if (loading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (allChats == null || allChats.isEmpty) {
      return const Center(child: Text('No chats available.'));
    }

    return ListView.builder(
      itemCount: allChats.length,
      itemBuilder: (context, index) {
        // final chat = allChats[index];
        return ListTile(
          // title: Text('sender: ${chat.senderName}'),
          // subtitle: Text('receiver: ${chat.receiverName}'),
        );
      },
    );
  }
}
