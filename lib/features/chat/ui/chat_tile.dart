import 'package:flutter/material.dart';

import '../../../core/constants/strings.dart';
import '../../../core/theme/styles.dart';

class ChatTile extends StatelessWidget {
  const ChatTile({
    super.key,
    required this.name,
    required this.lastMessage,
    required this.onTap,
    // required this.timestamp,
  });

  final String name;
  final String lastMessage;

  // final String timestamp;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        radius: Styles.radiusChatAvatar,
        backgroundColor: Styles.skillChipBackgroundColor,
        child: Text(
          name[0],
          style: TextStyle(fontSize: Styles.fontSizeChatAvatar),
        ),
      ),
      title: Text(name, style: Styles.chatTitleTextStyle),
      subtitle: Text(
        lastMessage,
        style: Styles.chatSubtitleTextStyle,
        maxLines: 2,
      ),
      // trailing: Text('${calculateDaysDifferenceAndFormat(timestamp)}'),
      trailing: Text(Str.mockDaysAgo),
      onTap: () {
        onTap();
      },
    );
  }
}
