import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/strings.dart';
import '../../../core/routing/routing.dart';
import 'rs_bottom_navigation_bar.dart';
import 'rs_navigation_drawer.dart';

class NavigationShellScaffold extends StatelessWidget {
  const NavigationShellScaffold({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    final isLargeScreen =
        MediaQuery.sizeOf(context).width > Str.smallScreenWidthThreshold;

    return Scaffold(
      body: Row(
        children: [
          if (isLargeScreen)
            RsNavigationRail(
              currentIndex: navigationShell.currentIndex,
              onTap:
                  (int index) => goToBranchDestination(index, navigationShell),
            ),
          Expanded(child: navigationShell),
        ],
      ),
      bottomNavigationBar:
          isLargeScreen
              ? null
              : RsBottomNavigationBar(
                onTap:
                    (int index) =>
                        goToBranchDestination(index, navigationShell),
                currentIndex: navigationShell.currentIndex,
              ),
    );
  }
}
