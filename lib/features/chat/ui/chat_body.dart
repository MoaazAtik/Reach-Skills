import 'package:flutter/material.dart';

class ChatBody extends StatelessWidget {
  final String? selectedChatId;
  final void Function(String selectedChatId) onTapChat;

  const ChatBody({super.key, this.selectedChatId, required this.onTapChat});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 10,
      itemBuilder:
          (context, index) => ListTile(
            title: Text('Chat $index'),
            onTap: () {
              onTapChat(index.toString());
            },
          ),
    );
  }
}
