import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/strings.dart';

Widget rsNavigationRail(BuildContext context) {
  return NavigationRail(
    selectedIndex: _calculateSelectedIndex(context),
    onDestinationSelected: (int idx) => _onItemTapped(idx, context),
    // labelType: NavigationRailLabelType.all,
    extended: true,

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

Widget rsNavigationDrawer(BuildContext context) {
  return NavigationDrawer(
    selectedIndex: _calculateSelectedIndex(context),
    onDestinationSelected: (int idx) => _onItemTapped(idx, context),

    children: [
      Row(children: [Icon(Icons.explore), Text(Str.exploreScreenLabel)]),
      Row(children: [Icon(Icons.chat), Text(Str.chatScreenTitle)]),
    ],
  );
}

int _calculateSelectedIndex(BuildContext context) {
  final String location = GoRouterState.of(context).uri.path;
  if (location.startsWith(Str.chatScreenRoutePath)) {
    return 1;
  }
  if (location.startsWith(Str.exploreScreenRoutePath)) {
    return 0;
  }
  return 0;
}

void _onItemTapped(int index, BuildContext context) {
  switch (index) {
    case 0:
      GoRouter.of(context).go(Str.exploreScreenRoutePath);
    case 1:
      GoRouter.of(context).go(Str.chatScreenRoutePath);
  }
}
