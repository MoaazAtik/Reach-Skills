import 'package:flutter/material.dart';
import 'package:reach_skills/core/theme/styles.dart';

class MessageTile extends StatelessWidget {
  const MessageTile({
    super.key,
    required this.messageContent,
    required this.senderName,
    required this.currentUserName,
  });

  final String messageContent;
  final String senderName;
  final String currentUserName;

  /*
  // final bool isMe;
  // final String time;
  // final String chatId;
  // final String imageUrl;
  // final String name;
  // final String lastMessage;
  // final String timestamp;
  // final void Function() onTap;
  // final void Function() onLongPress;
  // final void Function() onTapAvatar;
  // final void Function() onTapName;
  // final void Function() onTapMessage;
  // final void Function() onTapTimestamp;
  // final void Function() onTapImage;
  // final void Function() onTapLastMessage;
  // final void Function() onTapChat;
  // final void Function() onTapSender;
  // final void Function() onTapReceiver;
  // final void Function() onTapChatId;
  // final void Function() onTapUserId;
   */

  @override
  Widget build(BuildContext context) {
    final Color backgroundColor;
    final CrossAxisAlignment crossAxisAlignment;

    if (senderName != currentUserName) {
      backgroundColor = Styles.skillChipBackgroundColor;
      crossAxisAlignment = CrossAxisAlignment.start;
    } else {
      backgroundColor = Styles.buttonFullBackgroundColor;
      crossAxisAlignment = CrossAxisAlignment.end;
    }

    final Widget widget1;
    final Widget widget2;

    final Widget widgetMessageContent = Expanded(
      child: Column(
        crossAxisAlignment: crossAxisAlignment,
        children: [
          Text(senderName, style: Styles.messageNameTextStyle),
          SizedBox(height: Styles.spacingExtraSmall),
          Container(
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(Styles.borderRadius),
            ),
            padding: const EdgeInsets.symmetric(
              vertical: Styles.padding12,
              horizontal: Styles.paddingMedium,
            ),
            child: Text(messageContent, style: Styles.messageContentTextStyle),
          ),
        ],
      ),
    );
    final widgetAvatar = CircleAvatar(
      backgroundColor: backgroundColor,
      radius: Styles.radiusMessageAvatar,
    );

    if (senderName != currentUserName) {
      widget1 = widgetAvatar;
      widget2 = widgetMessageContent;
    } else {
      widget1 = widgetMessageContent;
      widget2 = widgetAvatar;
    }

    return Container(
      clipBehavior: Clip.none, // may fix render overflow issue (?)
      padding: const EdgeInsets.all(Styles.paddingMedium),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [widget1, SizedBox(width: Styles.spacingSmall), widget2],
      ),
    );
  }
}
