import 'package:flutter/material.dart';

import '../../../core/constants/strings.dart';
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
    final cardColor =
        interestType == InterestType.skill
            ? Color(0x96AAFFD0)
            : Color(0xD58DBAF6);

    // final buttonTextColor = Colors.red;

    return Card(
      color: cardColor,
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Container(
        padding: const EdgeInsets.all(8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  title,
                  style: TextStyle(fontSize: 20, color: Colors.grey[900]),
                ),
                Container(height: 10),
                Text(
                  userName,
                  style: TextStyle(fontSize: 13, color: Colors.grey[900]),
                ),
              ],
            ),
            TextButton(
              style: TextButton.styleFrom(foregroundColor: Colors.transparent),
              child: const Text(
                "${Str.reach}...",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: () {
                onReach();
              },
            ),
          ],
        ),
      ),
    );
  }
}
