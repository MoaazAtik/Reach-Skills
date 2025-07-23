import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:reach_skills/core/utils/utils.dart';
import 'package:reach_skills/features/common/widgets/scaffold_app_bar_bodies.dart';
import 'package:reach_skills/features/explore/ui/explore_viewmodel.dart';
import 'package:reach_skills/features/help/ui/help_body.dart';
import 'package:reach_skills/features/help/ui/onboarding.dart';

import '../../features/auth/ui/auth_screen.dart';
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
          // : Str.exploreScreenRoutePath,
          : Str.profileScreenRoutePath,
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
                return buildScaffoldAppBarBodies(
                  context: context,
                  masterBody: ExploreBody(
                    onInterestTap: (interest) {
                      onInterestTap(context, interest);
                    },
                  ),
                  appBarTitle: Str.exploreScreenTitle,
                );
              },
              routes: [
                GoRoute(
                  name: Str.detailsScreenRouteName,
                  path: Str.detailsScreenRoutePath,
                  builder: (BuildContext context, GoRouterState state) {
                    final interest = state.extra;

                    return buildScaffoldAppBarBodies(
                      context: context,
                      masterBody: ExploreBody(
                        onInterestTap: (interest) {
                          onInterestTap(context, interest);
                        },
                      ),
                      detailBody: InterestDetails(
                        interest:
                            interest != null ? interest as InterestModel : null,
                        // Todo implement
                        onTapReach: () {
                          // context.goNamed(Str.chatScreenRouteName);
                        },
                      ),
                      appBarTitle: Str.exploreScreenTitle,
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
                return buildScaffoldAppBarBodies(
                  context: context,
                  masterBody: ChatBody(
                    selectedChatId: null,
                    onTapChat: (String chatId) {
                      onTapChat(context, chatId);
                    },
                  ),
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
                      // Todo fix messages are not showing on large screen
                      detailBody = MessagesBody(selectedChatId: chatId!);
                    } else {
                      masterBody = MessagesBody(selectedChatId: chatId!);
                    }

                    return buildScaffoldAppBarBodies(
                      context: context,
                      masterBody: masterBody,
                      detailBody: detailBody,
                      appBarTitle: Str.messagesScreenTitle,
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
      name: Str.authScreenRouteName,
      path: Str.authScreenRoutePath,
      builder: (BuildContext context, GoRouterState state) {
        final bool isLoggedIn = context.watch<AuthViewModel>().isLoggedIn;
        if (isLoggedIn) {
          WidgetsBinding.instance.addPostFrameCallback(
            (Duration duration) => context.goNamed(Str.exploreScreenRouteName),
          );
        }
        return buildScaffoldAppBarBodies(
          context: context,
          masterBody: AuthScreen(),
          appBarTitle: Str.authScreenTitle,
          isLoggedIn: isLoggedIn,
        );
      },
    ),

    GoRoute(
      name: Str.profileScreenRouteName,
      path: Str.profileScreenRoutePath,
      builder: (BuildContext context, GoRouterState state) {
        VoidCallback toggleEdit = context.read<ProfileViewModel>().toggleEdit;

        return buildScaffoldAppBarBodies(
          context: context,
          masterBody: ProfileBody(onSignInPressed: () => onTapSignIn(context)),
          appBarTitle: Str.profileScreenTitle,
          appBarEditAction: true,
          onTapEdit: toggleEdit,
        );
      },
    ),

    GoRoute(
      name: Str.helpScreenRouteName,
      path: Str.helpScreenRoutePath,
      builder: (BuildContext context, GoRouterState state) {
        return buildScaffoldAppBarBodies(
          context: context,
          masterBody: HelpBody(
            onTapOnboardingGuide: () {
              onTapOnboardingGuide(context);
            },
          ),
          appBarTitle: Str.helpScreenTitle,
        );
      },
    ),
  ],

  errorBuilder: (context, state) {
    return ErrorRoute();
  },
);

Widget buildScaffoldAppBarBodies({
  required BuildContext context,
  required Widget masterBody,
  Widget? detailBody,
  required String appBarTitle,
  bool? isLoggedIn,
  bool appBarEditAction = false,
  VoidCallback? onTapEdit,
}) {
  return ScaffoldAppBarBodies(
    masterBody: masterBody,
    detailBody: detailBody,
    appBarTitle: appBarTitle,
    isLoggedIn: isLoggedIn ?? context.watch<AuthViewModel>().isLoggedIn,
    appBarEditAction: appBarEditAction,
    onTapEdit: onTapEdit,
    onTapSignIn: () => onTapSignIn(context),
    onTapSignOut: () => onTapSignOut(context),
    onTapEditProfile: () => onTapEditProfile(context),
    onTapHelp: () => onTapHelp(context),
  );
}

void goToBranchDestination(int index, StatefulNavigationShell navigationShell) {
  navigationShell.goBranch(
    index,
    initialLocation: index == navigationShell.currentIndex,
  );
}

void onInterestTap(BuildContext context, InterestModel interest) {
  final bool isOwner =
      interest.userId == context.read<AuthViewModel>().currentUser?.uid;

  if (checkLargeScreen(context)) {
    context.goNamed(
      Str.detailsScreenRouteName,
      pathParameters: {Str.detailsScreenParamId: interest.id},
      extra: interest,
    );
    print('current path : ${GoRouterState.of(context).fullPath}');
  } else {
    showDetailsScreenDialog(
      context,
      interest: interest,
      onTapSave:
          !isOwner
              ? null
              : (interest) {
                /* This lambda is required even if it's empty
                 because null check of 'onTapSave' is done by InterestDetails.
                 Maybe implement this later.
                 // context.read<ProfileViewModel>().saveInterest(interest);
                 */
              },
      onTapReach: () {
        // Todo implement
      },
    );
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

void onTapSignIn(BuildContext context) {
  context.goNamed(Str.authScreenRouteName);
}

void onTapSignOut(BuildContext context) {
  context.read<AuthViewModel>().signOut();
  context.goNamed(Str.exploreScreenRouteName);
}

void onTapEditProfile(BuildContext context) {
  context.goNamed(Str.profileScreenRouteName);
}

void onTapHelp(BuildContext context) {
  context.goNamed(Str.helpScreenRouteName);
}
