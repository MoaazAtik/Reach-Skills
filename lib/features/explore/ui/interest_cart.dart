import 'package:flutter/material.dart';

import '../../common/data/interest_model.dart';

class InterestCard extends StatelessWidget {
  const InterestCard({
    super.key,
    required this.interestType,
    required this.title,
    required this.userName,
    required this.onReach
  });

  final InterestType interestType;
  final String title;
  final String userName;
  final Function onReach;

  @override
  Widget build(BuildContext context) {
    final cardColor =
        interestType == InterestType.skill
            ? Colors.green.withValues(alpha: 0.7)
            : Colors.blue.withValues(alpha: 0.7);

    // final buttonTextColor = Colors.red;

    return Card(
      color: cardColor,
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Container(
        padding: const EdgeInsets.all(15),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  title,
                  style: TextStyle(fontSize: 24, color: Colors.grey[900]),
                ),
                Container(height: 10),
                Text(
                  userName,
                  style: TextStyle(fontSize: 15, color: Colors.grey[900]),
                ),
              ],
            ),
            const Spacer(),
            TextButton(
              style: TextButton.styleFrom(foregroundColor: Colors.transparent),
              child: const Text(
                "REACH...",
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
