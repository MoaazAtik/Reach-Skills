import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/strings.dart';

class RsNavigationRail extends StatelessWidget {
  const RsNavigationRail({super.key});

  @override
  Widget build(BuildContext context) {
    return NavigationRail(
      selectedIndex: _calculateSelectedIndex(context),
      onDestinationSelected: (int idx) => _onItemTapped(idx, context),
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
}


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

int _calculateSelectedIndex(BuildContext context) {
  final String location = GoRouterState.of(context).uri.path;
  print('nav rail location: $location');
  // if (location.startsWith(Str.chatScreenRoutePath)) {
  if (location.startsWith('/chat')) {
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
      // GoRouter.of(context).go(Str.chatScreenRoutePath);
      // GoRouter.of(context).go('/chat/:id');
      // GoRouter.of(context).go('/chat/');
      // GoRouter.of(context).push('/chat');
      GoRouter.of(context).go('/chat'); // shows '/chat' in browser url. 'push' doesn't
  }
}
