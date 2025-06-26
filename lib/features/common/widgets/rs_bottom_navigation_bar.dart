import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/strings.dart';

Widget rsNavigationBar(BuildContext context) {
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
    currentIndex: _calculateSelectedIndex(context),
    onTap: (int idx) => _onItemTapped(idx, context),
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
