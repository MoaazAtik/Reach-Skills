import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../auth/ui/auth_screen.dart';
import 'chat_viewmodel.dart';
import 'messages_screen.dart';

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
    final chatsError = chatViewModel.chatsError;

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

    if (chatsError != null) {
      return Center(child: Text(chatsError.toString()));
    }

    if (allChats == null || allChats.isEmpty) {
      return const Center(child: Text('No chats available.'));
    }

    return ListView.builder(
      itemCount: allChats.length,
      itemBuilder: (context, index) {
        final chat = allChats[index];
        return Card(
          child: ListTile(
            title: Text('Created by: ${chat.person1Name}'),
            subtitle: Text('To: ${chat.person2Name}'),
            trailing: Text(
              'Updated at: ${DateTime.fromMillisecondsSinceEpoch(chat.updatedAt).toString()}',
            ),
            onTap:
                () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => MessagesScreen(chatId: chat.id),
                  ),
                ),
          ),
        );
      },
    );
  }
}
