import 'package:flutter/material.dart';

import '../../../core/constants/strings.dart';
import '../../../core/utils/utils.dart';

class RsNavigationRail extends StatelessWidget {
  const RsNavigationRail({
    super.key,
    required this.onTap,
    required this.currentIndex,
  });

  final void Function(int index) onTap;
  final int currentIndex;

  @override
  Widget build(BuildContext context) {
    final isLargeScreen = checkScreenSize(context) == RsScreenSize.large;
    final labelType =
        !isLargeScreen
            ? NavigationRailLabelType.all
            : NavigationRailLabelType.none;

    return NavigationRail(
      selectedIndex: currentIndex,
      onDestinationSelected: (int index) => onTap(index),
      labelType: labelType,
      extended: isLargeScreen,

      destinations: [
        NavigationRailDestination(
          icon: Icon(Icons.explore),
          label: Text(Str.exploreScreenLabel),
        ),
        NavigationRailDestination(
          icon: Icon(Icons.chat),
          label: Text(Str.chatScreenTitle),
        ),
      ],
    );
  }
}
