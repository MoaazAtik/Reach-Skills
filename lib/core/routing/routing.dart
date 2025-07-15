import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:reach_skills/core/utils/utils.dart';
import 'package:reach_skills/features/common/widgets/scaffold_app_bar_bodies.dart';
import 'package:reach_skills/features/explore/ui/explore_viewmodel.dart';
import 'package:reach_skills/features/help/ui/help_body.dart';
import 'package:reach_skills/features/help/ui/onboarding.dart';

import '../../features/auth/ui/auth_viewmodel.dart';
import '../../features/chat/ui/chat_body.dart';
import '../../features/chat/ui/messages_body.dart';
import '../../features/common/data/interest_model.dart';
import '../../features/common/widgets/error_route.dart';
import '../../features/common/widgets/interest_details.dart';
import '../../features/common/widgets/navigation_shell_scaffold.dart';
import '../../features/explore/ui/explore_body.dart';
import '../../features/profile/ui/profile_body.dart';
import '../../features/profile/ui/profile_viewmodel.dart';
import '../constants/strings.dart';

final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>(
  debugLabel: 'root',
);

GoRouter getRouter(bool isFirstInitialization) => GoRouter(
  // For showing 'details' dialog later perhaps
  navigatorKey: rootNavigatorKey,
  initialLocation:
      isFirstInitialization
          ? Str.onboardingScreenRoutePath
          : Str.exploreScreenRoutePath,
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
                return ScaffoldAppBarBodies(
                  masterBody: ChatBody(
                    selectedChatId: null,
                    onTapChat: (String chatId) {
                      onTapChat(context, chatId);
                    },
                  ),
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
                    final isLargeScreen = checkLargeScreen(context);
                    Widget masterBody;
                    Widget? detailBody;
                    if (isLargeScreen) {
                      masterBody = ChatBody(
                        selectedChatId: chatId,
                        onTapChat: (String chatId) {
                          onTapChat(context, chatId);
                        },
                      );
                      detailBody = MessagesBody(selectedChatId: chatId!);
                    } else {
                      masterBody = MessagesBody(selectedChatId: chatId!);
                    }

                    return ScaffoldAppBarBodies(
                      masterBody: masterBody,
                      detailBody: detailBody,
                      appBarTitle: Str.messagesScreenTitle,
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
    GoRoute(
      name: Str.onboardingScreenRouteName,
      path: Str.onboardingScreenRoutePath,
      builder: (BuildContext context, GoRouterState state) {
        return Scaffold(
          body: Onboarding(
            endOnboarding: () {
              endOnboarding(context);
            },
          ),
        );
      },
    ),
    GoRoute(
      name: Str.profileScreenRouteName,
      path: Str.profileScreenRoutePath,
      builder: (BuildContext context, GoRouterState state) {
        VoidCallback toggleEdit = context.read<ProfileViewModel>().toggleEdit;

        return ScaffoldAppBarBodies(
          masterBody: ProfileBody(),
          appBarTitle: Str.profileScreenTitle,
          isLoggedIn: context.watch<AuthViewModel>().isLoggedIn,
          appBarEditAction: true,
          onTapEdit: toggleEdit,
        );
      },
    ),

    GoRoute(
      name: Str.helpScreenRouteName,
      path: Str.helpScreenRoutePath,
      builder: (BuildContext context, GoRouterState state) {
        return ScaffoldAppBarBodies(
          masterBody: HelpBody(
            onTapOnboardingGuide: () {
              onTapOnboardingGuide(context);
            },
          ),
          appBarTitle: Str.helpScreenTitle,
          isLoggedIn: context.watch<AuthViewModel>().isLoggedIn,
        );
      },
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
    // Todo: replace isOwner
    showDetailsScreenDialog(context, isOwner: false, interest: interest);
  }
}

void onTapChat(BuildContext context, String selectedChatId) {
  context.go('${Str.chatScreenRoutePath}/$selectedChatId');
  // else if (!isLargeScreen) {
  //   // context.push('/chat/$index');
  //   context.go('/chat/$index');
  // }
}

void onTapOnboardingGuide(BuildContext context) {
  context.goNamed(Str.onboardingScreenRouteName);
  // context.read<ExploreViewModel>().setIsFirstInitialization(true);
}

void endOnboarding(BuildContext context) {
  context.goNamed(Str.exploreScreenRouteName);
  context.read<ExploreViewModel>().setIsFirstInitialization(false);
}
