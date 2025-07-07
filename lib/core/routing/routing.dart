import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:reach_skills/core/utils/utils.dart';
import 'package:reach_skills/features/common/widgets/scaffold_app_bar_bodies.dart';

import '../../features/auth/ui/auth_viewmodel.dart';
import '../../features/chat/ui/chat_body.dart';
import '../../features/common/data/interest_model.dart';
import '../../features/common/widgets/error_route.dart';
import '../../features/common/widgets/interest_details.dart';
import '../../features/common/widgets/navigation_shell_scaffold.dart';
import '../../features/common/widgets/scaffold_app_bar.dart';
import '../../features/explore/ui/explore_body.dart';
import '../constants/strings.dart';
import '../theme/styles.dart';

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
                return ScaffoldAppBarBodies(
                  masterBody: ExploreBody(
                    onInterestTap: (interest) {
                      onInterestTap(context, interest);
                    },
                  ),
                  appBarTitle: Str.exploreScreenTitle,
                  isLoggedIn: context.watch<AuthViewModel>().isLoggedIn,
                );
              },
              routes: [
                GoRoute(
                  name: Str.detailsScreenRouteName,
                  path: Str.detailsScreenRoutePath,
                  builder: (BuildContext context, GoRouterState state) {
                    final interest = state.extra;

                    return ScaffoldAppBarBodies(
                      masterBody: ExploreBody(
                        onInterestTap: (interest) {
                          onInterestTap(context, interest);
                        },
                      ),
                      detailBody: InterestDetails(
                        isOwner: false,
                        interest: interest as InterestModel,
                      ),
                      appBarTitle: Str.exploreScreenTitle,
                      isLoggedIn: context.watch<AuthViewModel>().isLoggedIn,
                    );
                  },
                ),
              ],
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
                  isLoggedIn: context.watch<AuthViewModel>().isLoggedIn,
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
                      isLoggedIn: context.watch<AuthViewModel>().isLoggedIn,
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

void onInterestTap(BuildContext context, InterestModel interest) {
  if (checkLargeScreen(context)) {
    // Todo: replace interest.userId with interest.id
    context.goNamed(
      Str.detailsScreenRouteName,
      pathParameters: {Str.detailsScreenParamId: interest.userId},
      extra: interest,
    );
  } else {
    showAdaptiveDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Styles.borderRadius),
          ),
          backgroundColor: Styles.rsDefaultSurfaceColor,
          child: InterestDetails(isOwner: false, interest: interest),
        );
      },
    );
  }
}
