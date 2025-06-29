import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../features/chat/ui/chat_body.dart';
import '../../features/common/widgets/rs_app_bar.dart';
import '../../features/common/widgets/rs_bottom_navigation_bar.dart';
import '../../features/common/widgets/rs_navigation_drawer.dart';
import '../../features/explore/ui/explore_body.dart';
import '../constants/strings.dart';

final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>(
  debugLabel: 'root',
);

final router = GoRouter(
  // For showing 'details' dialog later perhaps
  navigatorKey: rootNavigatorKey,
  initialLocation: Str.exploreScreenRoutePath,
  debugLogDiagnostics: true,
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (
        BuildContext context,
        GoRouterState state,
        StatefulNavigationShell navigationShell,
      ) {
        final isLargeScreen =
            MediaQuery.sizeOf(context).width > Str.smallScreenWidthThreshold;

        return Scaffold(
          body: Row(
            children: [
              if (isLargeScreen)
                RsNavigationRail(
                  currentIndex: navigationShell.currentIndex,
                  onTap:
                      (int index) =>
                          goToBranchDestination(index, navigationShell),
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
                    // selectedIndex: state.uri.pathSegments.last,
                  ),
        );
      },
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              name: Str.exploreScreenRouteName,
              path: Str.exploreScreenRoutePath,
              builder: (BuildContext context, GoRouterState state) {
                return Scaffold(
                  body: ExploreBody(),
                  appBar: rsAppBar(
                    title: Str.exploreScreenTitle,
                    actions: [
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.more_vert_rounded),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              name: Str.chatScreenRouteName,
              path: Str.chatScreenRoutePath,
              builder: (BuildContext context, GoRouterState state) {
                return ChatBody();
              },
              routes: [
                GoRoute(
                  name: Str.messagesScreenRouteName,
                  path: Str.messagesScreenRoutePath,
                  builder: (BuildContext context, GoRouterState state) {
                    final chatId =
                        state.pathParameters[Str.messagesScreenParamId];
                    return ChatBody(selectedChatId: chatId);
                  },
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  ],
  errorBuilder: (context, state) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              Str.screenNotFoundMessage,
              style: TextStyle(color: Colors.amber),
            ),
            ElevatedButton(
              onPressed: () => context.go(Str.exploreScreenRoutePath),
              child: Text(Str.exploreScreenRouteName),
            ),
          ],
        ),
      ),
    );
  },
);

void goToBranchDestination(int index, StatefulNavigationShell navigationShell) {
  navigationShell.goBranch(
    index,
    initialLocation: index == navigationShell.currentIndex,
  );
}
