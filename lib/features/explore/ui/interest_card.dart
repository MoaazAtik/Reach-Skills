import 'package:flutter/material.dart';

import '../../../core/theme/styles.dart';
import '../../common/data/interest_model.dart';

class InterestCard extends StatelessWidget {
  const InterestCard({
    super.key,
    required this.interestType,
    required this.title,
    required this.userName,
    required this.onTap,
  });

  final InterestType interestType;
  final String title;
  final String userName;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    final background =
        interestType == InterestType.skill
            ? Styles.skillCardBackgroundColor
            : Styles.wishCardBackgroundColor;

    return InkWell(
      onTap: () {
        onTap();
      },
      borderRadius: BorderRadius.circular(Styles.borderRadius),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          AspectRatio(
            aspectRatio: 1 / 1,
            child: Ink(
              decoration: BoxDecoration(
                gradient: background,
                borderRadius: BorderRadius.circular(Styles.borderRadius),
              ),
              child: Icon(
                Icons.explore,
                size: Styles.interestIconSize,
                blendMode: BlendMode.overlay, // BlendMode.clear,
              ),
            ),
          ),
          SizedBox(height: 2),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.all(Styles.paddingExtraSmall),
              child: Text(
                '$title, $userName',
                style: TextStyle(
                  overflow: TextOverflow.fade,
                  fontSize: Styles.fontSizeChip,
                  // color: Colors.grey[900],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
