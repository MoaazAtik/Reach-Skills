import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/strings.dart';

Widget rsNavigationBar(BuildContext context,StatefulNavigationShell navigationShell) {
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
    currentIndex: _calculateSelectedIndex(context,navigationShell),
    onTap: (int idx) => _onItemTapped(idx, context, navigationShell),
  );
}

class RsBottomNavigationBar extends StatelessWidget {
  const RsBottomNavigationBar({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

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
      currentIndex: _calculateSelectedIndex(context,navigationShell),
      onTap: (int idx) => _onItemTapped(idx, context, navigationShell),
    );
  }
}


int _calculateSelectedIndex(BuildContext context,StatefulNavigationShell navigationShell) {
  // final String location = GoRouterState.of(context).uri.path;

  // // print('navigation bar : $location');
  // // print('name: ${GoRouterState.of(context).name}');
  // print('topRoute: ${GoRouterState.of(context).topRoute}');
  // // print('path: ${GoRouterState.of(context).path}');
  // print('fullPath: ${GoRouterState.of(context).fullPath}');
  // print('uri: ${GoRouterState.of(context).uri}');
  // // print('uri.path: ${GoRouterState.of(context).uri.path}');
  // // print('uri.query: ${GoRouterState.of(context).uri.query}');

  // if (location.startsWith(Str.chatScreenRoutePath)) {
  //   return 1;
  // }
  // if (location.startsWith(Str.exploreScreenRoutePath)) {
  //   return 0;
  // }
  // return 0;

  // return StatefulNavigationShell.of(context).currentIndex;
  // print('StatefulNavigationShell.of(context).currentIndex: ${GoRouterState.of(context)}');

  return navigationShell.currentIndex; // Todo replace with 'context...
}

void _onItemTapped(int index, BuildContext context,StatefulNavigationShell navigationShell) {
  // switch (index) {
  //   case 0:
  //     GoRouter.of(context).go(Str.exploreScreenRoutePath);
  //   case 1:
  //     GoRouter.of(context).go(Str.chatScreenRoutePath);
  // }
  navigationShell.goBranch(
    index,
    initialLocation: index == navigationShell.currentIndex,
  );
}
