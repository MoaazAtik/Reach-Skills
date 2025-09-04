import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/routing/routing.dart';
import '../../../core/utils/utils.dart';
import 'rs_bottom_navigation_bar.dart';
import 'rs_navigation_rail.dart';

class NavigationShellScaffold extends StatelessWidget {
  const NavigationShellScaffold({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    final isMidOrLargeScreen = checkScreenSize(context) != RsScreenSize.small;

    return Scaffold(
      body: Row(
        children: [
          if (isMidOrLargeScreen)
            RsNavigationRail(
              currentIndex: navigationShell.currentIndex,
              onTap:
                  (int index) => goToBranchDestination(index, navigationShell),
            ),
          Expanded(child: navigationShell),
        ],
      ),
      bottomNavigationBar:
          isMidOrLargeScreen
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
