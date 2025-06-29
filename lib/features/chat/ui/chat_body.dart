import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/strings.dart';
import '../../common/widgets/rs_app_bar.dart';

class ChatBody extends StatelessWidget {
  final String? selectedChatId;

  const ChatBody({super.key, this.selectedChatId});

  @override
  Widget build(BuildContext context) {
    final isLargeScreen =
        MediaQuery.sizeOf(context).width > Str.smallScreenWidthThreshold;

    return Scaffold(
      body: Row(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: 10,
              itemBuilder:
                  (context, index) => ListTile(
                    title: Text('Chat $index'),
                    onTap: () {
                      if (isLargeScreen) {
                        context.go('/chat/$index');
                      } else {
                        // context.push('/chat/$index');
                        context.go('/chat/$index');
                      }
                    },
                  ),
            ),
          ),
          if (isLargeScreen && selectedChatId != null)
            Expanded(
              child: ListView.builder(
                itemCount: 10,
                itemBuilder:
                    (context, index) => ListTile(
                      title: Text('chatId: $selectedChatId,\n Message $index'),
                    ),
              ),
            )
          else if (!isLargeScreen && selectedChatId != null)
            Expanded(
              // Todo replace with MessageScreen
              child: ListView.builder(
                itemCount: 10,
                itemBuilder:
                    (context, index) => ListTile(
                      title: Text(
                        'smallll\n chatId: $selectedChatId,\n Message $index',
                      ),
                    ),
              ),
            ),
        ],
      ),
      appBar: rsAppBar(
        title: Str.chatScreenTitle,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.more_vert_rounded),
            ),
          ),
        ],
      ),
    );
  }
}
