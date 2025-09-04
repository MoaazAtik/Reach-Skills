import 'package:flutter/material.dart';

import '../../../core/constants/strings.dart';

class RsBottomNavigationBar extends StatelessWidget {
  const RsBottomNavigationBar({
    super.key,
    required this.onTap,
    required this.currentIndex,
  });

  final void Function(int index) onTap;
  final int currentIndex;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.explore),
          label: Str.exploreScreenLabel,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.chat),
          label: Str.chatScreenTitle,
        ),
      ],
      currentIndex: currentIndex,
      onTap: (int index) => onTap(index),
    );
  }
}
