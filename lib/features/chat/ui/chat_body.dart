import 'package:flutter/material.dart';
import 'package:reach_skills/features/chat/ui/chat_tile.dart';

import '../../../core/constants/strings.dart';

class ChatBody extends StatelessWidget {
  final String? selectedChatId;
  final void Function(String selectedChatId) onTapChat;

  const ChatBody({super.key, this.selectedChatId, required this.onTapChat});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 10,
      itemBuilder:
          (context, index) => ChatTile(
            // Todo replace chat name and message
            name: 'Chat $index user name',
            lastMessage: '${Str.mockMessage1} ${Str.mockMessage2}',
            onTap: () => onTapChat(index.toString()),
          ),
    );
  }
}
