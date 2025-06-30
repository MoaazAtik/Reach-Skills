import 'package:flutter/material.dart';

import '../../../core/constants/strings.dart';
import '../../../core/constants/values.dart';
import '../../../core/theme/styles.dart';
import '../../common/data/interest_model.dart';

class InterestCard extends StatelessWidget {
  const InterestCard({
    super.key,
    required this.interestType,
    required this.title,
    required this.userName,
    required this.onReach,
  });

  final InterestType interestType;
  final String title;
  final String userName;
  final Function onReach;

  @override
  Widget build(BuildContext context) {
    final background =
        interestType == InterestType.skill
            ? Styles.skillCardBackgroundColor
            : Styles.wishCardBackgroundColor;

    return InkWell(
      onTap: () {
        onReach();
      },
      borderRadius: BorderRadius.circular(Values.borderRadius),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          AspectRatio(
            aspectRatio: 1 / 1,
            child: Ink(
              decoration: BoxDecoration(
                gradient: background,
                borderRadius: BorderRadius.circular(Values.borderRadius),
              ),
              child: Icon(
                Icons.explore,
                size: Values.interestIconSize,
                blendMode: BlendMode.overlay, // BlendMode.clear,
              ),
            ),
          ),
          SizedBox(height: 4),
          Padding(
            padding: const EdgeInsets.all(Values.paddingExtraSmall),
            child: Text(
              '$title, $userName',
              style: TextStyle(
                fontSize: Values.fontSizeChip,
                // color: Colors.grey[900],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
