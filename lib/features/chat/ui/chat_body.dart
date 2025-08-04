import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reach_skills/features/chat/ui/chat_tile.dart';

import '../../../core/constants/strings.dart';
import 'chat_viewmodel.dart';

class ChatBody extends StatelessWidget {
  final String? selectedChatId;
  final void Function(String selectedChatId) onTapChat;
  final VoidCallback onSignInPressed;

  const ChatBody({
    super.key,
    this.selectedChatId,
    required this.onTapChat,
    required this.onSignInPressed,
  });

  @override
  Widget build(BuildContext context) {
    final chatViewModel = context.watch<ChatViewModel>();
    final isLoggedIn = chatViewModel.isLoggedIn;
    final loading = chatViewModel.loading;
    final allChats = chatViewModel.allChats;
    final chatsError = chatViewModel.chatsError;
    final authError = chatViewModel.authError;

    if (!isLoggedIn) {
      return Column(
        children: [
          const SizedBox(height: 40),
          Text(Str.noUserInfoMessage),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: onSignInPressed,
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

    if (authError != null) {
      return Center(child: Text(authError));
    }

    if (allChats == null || allChats.isEmpty) {
      return const Center(child: Text(Str.noChatsMessage));
    }

    return ListView.builder(
      itemCount: allChats.length,
      // Todo remove Mock comments
      // itemCount: 10,
      itemBuilder: (context, index) {
        // Todo update user name in Firebase auth when user changes name in profile because it's needed for the view model here '_currentUser?.displayName'
        final hisName = context.read<ChatViewModel>().determineChatterProperty(
          chat: allChats[index],
          property: 'name',
          mine: false,
        );
        return ChatTile(
          name: hisName,
          // name: 'Chat $index user name',
          // Todo replace mock message
          lastMessage: '${Str.mockMessage1} ${Str.mockMessage2}',
          timestamp: allChats[index].updatedAt,
          onTap: () => onTapChat(allChats[index].id),
          // onTap: () => onTapChat(index.toString()),
        );
      },
    );
  }
}
