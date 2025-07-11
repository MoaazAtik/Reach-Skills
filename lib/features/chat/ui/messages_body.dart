import 'package:flutter/material.dart';
import 'package:reach_skills/features/chat/ui/message_tile.dart';

import '../../../core/constants/strings.dart';

class MessagesBody extends StatelessWidget {
  const MessagesBody({super.key, required this.selectedChatId});

  final String selectedChatId;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 10,
      itemBuilder:
          (context, index) => MessageTile(
            messageContent:
                index % 2 == 0 ? Str.mockMessage3 : Str.mockMessage4,
            senderName: index % 2 == 0 ? Str.mockUserName : Str.mockUserName2,
            currentUserName: Str.mockUserName,
          ),
    );
  }
}
