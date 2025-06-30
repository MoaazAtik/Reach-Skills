import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../features/chat/ui/chat_body.dart';
import '../../features/common/widgets/error_route.dart';
import '../../features/common/widgets/navigation_shell_scaffold.dart';
import '../../features/common/widgets/scaffold_app_bar.dart';
import '../../features/explore/ui/explore_body.dart';
import '../constants/strings.dart';

final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>(
  debugLabel: 'root',
);

final router = GoRouter(
  // For showing 'details' dialog later perhaps
  navigatorKey: rootNavigatorKey,
  initialLocation: Str.exploreScreenRoutePath,
  // debugLogDiagnostics: true,
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (
        BuildContext context,
        GoRouterState state,
        StatefulNavigationShell navigationShell,
      ) {
        return NavigationShellScaffold(navigationShell: navigationShell);
      },
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              name: Str.exploreScreenRouteName,
              path: Str.exploreScreenRoutePath,
              builder: (BuildContext context, GoRouterState state) {
                return ScaffoldAppBar(
                  body: ExploreBody(),
                  appBarTitle: Str.exploreScreenTitle,
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
                return ScaffoldAppBar(
                  body: ChatBody(),
                  appBarTitle: Str.chatScreenTitle,
                );
              },
              routes: [
                GoRoute(
                  name: Str.messagesScreenRouteName,
                  path: Str.messagesScreenRoutePath,
                  builder: (BuildContext context, GoRouterState state) {
                    final chatId =
                        state.pathParameters[Str.messagesScreenParamId];
                    return ScaffoldAppBar(
                      body: ChatBody(selectedChatId: chatId),
                      appBarTitle: Str.chatScreenTitle,
                    );
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
    return ErrorRoute();
  },
);

void goToBranchDestination(int index, StatefulNavigationShell navigationShell) {
  navigationShell.goBranch(
    index,
    initialLocation: index == navigationShell.currentIndex,
  );
}
