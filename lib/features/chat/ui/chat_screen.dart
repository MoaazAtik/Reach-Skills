import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/strings.dart';
import '../../auth/ui/auth_screen.dart';
import 'chat_viewmodel.dart';
import 'messages_screen.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

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
          Text(Str.noUserInfoMessage),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () {
              Navigator.of(
                context,
              ).push(MaterialPageRoute(builder: (_) => const AuthScreen()));
            },
            child: const Text(Str.signIn),
          ),
        ],
      );
    }

    if (loading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (chatsError != null) {
      return Center(child: Text(chatsError));
    }

    if (allChats == null || allChats.isEmpty) {
      return const Center(child: Text(Str.noChatsMessage));
    }

    return ListView.builder(
      itemCount: allChats.length,
      itemBuilder: (context, index) {
        final chat = allChats[index];
        return Card(
          child: ListTile(
            title: Text('${Str.createdBy}: ${chat.person1Name}'),
            subtitle: Text('${Str.to}: ${chat.person2Name}'),
            trailing: Text(
              '${Str.updatedAt}: ${DateTime.fromMillisecondsSinceEpoch(chat.updatedAt).toString()}',
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
