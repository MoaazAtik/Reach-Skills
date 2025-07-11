import 'package:flutter/material.dart';

class MessagesBody extends StatelessWidget {
  const MessagesBody({super.key, required this.selectedChatId});

  final String selectedChatId;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 10,
      itemBuilder:
          (context, index) => ListTile(
            title: Text('chatId: $selectedChatId,\n Message $index'),
          ),
    );
  }
}
