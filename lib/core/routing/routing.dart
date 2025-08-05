import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:reach_skills/core/utils/utils.dart';
import 'package:reach_skills/features/common/widgets/scaffold_app_bar_bodies.dart';
import 'package:reach_skills/features/explore/ui/explore_viewmodel.dart';
import 'package:reach_skills/features/help/ui/help_body.dart';
import 'package:reach_skills/features/help/ui/onboarding.dart';

import '../../features/auth/data/auth_repository_impl.dart';
import '../../features/auth/ui/auth_screen.dart';
import '../../features/auth/ui/auth_viewmodel.dart';
import '../../features/chat/data/chat_repository_impl.dart';
import '../../features/chat/ui/chat_body.dart';
import '../../features/chat/ui/chat_viewmodel.dart';
import '../../features/chat/ui/messages_body.dart';
import '../../features/chat/ui/messages_viewmodel.dart';
import '../../features/common/data/interest_model.dart';
import '../../features/common/widgets/error_route.dart';
import '../../features/common/widgets/interest_details.dart';
import '../../features/common/widgets/navigation_shell_scaffold.dart';
import '../../features/explore/ui/explore_body.dart';
import '../../features/profile/data/profile_repository_impl.dart';
import '../../features/profile/ui/profile_body.dart';
import '../../features/profile/ui/profile_viewmodel.dart';
import '../constants/strings.dart';
import '../preferences_repository/data/preferences_repository_impl.dart';

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
      // Navigation Shell
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
            ShellRoute(
              builder: (context, state, child) {
                return ChangeNotifierProvider(
                  create:
                      (BuildContext _) => ExploreViewModel(
                        profileRepository:
                            context.read<ProfileRepositoryImpl>(),
                      ),
                  child: child,
                );
              },
              routes: [
                // Explore Screen
                GoRoute(
                  name: Str.exploreScreenRouteName,
                  path: Str.exploreScreenRoutePath,
                  builder: _exploreScreenBuilder,
                  routes: [
                    // Explore's Details Screen
                    GoRoute(
                      name: Str.detailsExploreScreenRouteName,
                      path: Str.detailsScreenRoutePath,
                      pageBuilder: _detailsScreenBuilder,
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            ShellRoute(
              builder: (context, state, child) {
                return ChangeNotifierProvider(
                  create:
                      (BuildContext _) => ChatViewModel(
                        authRepository: context.read<AuthRepositoryImpl>(),
                        chatRepository: context.read<ChatRepositoryImpl>(),
                      ),
                  child: child,
                );
              },
              routes: [
                // Chat Screen
                GoRoute(
                  name: Str.chatScreenRouteName,
                  path: Str.chatScreenRoutePath,
                  builder: _chatScreenBuilder,
                  routes: [
                    // Messages Screen
                    GoRoute(
                      name: Str.messagesScreenRouteName,
                      path: Str.messagesScreenRoutePath,
                      builder: _messagesScreenBuilder,
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ],
    ),

    // Onboarding Screen
    GoRoute(
      name: Str.onboardingScreenRouteName,
      path: Str.onboardingScreenRoutePath,
      builder: _onboardingScreenBuilder,
    ),

    // Auth Screen
    GoRoute(
      name: Str.authScreenRouteName,
      path: Str.authScreenRoutePath,
      builder: _authScreenBuilder,
    ),

    ShellRoute(
      builder: (context, state, child) {
        return ChangeNotifierProvider(
          create:
              (BuildContext _) => ProfileViewModel(
                authRepository: context.read<AuthRepositoryImpl>(),
                profileRepository: context.read<ProfileRepositoryImpl>(),
              ),
          child: child,
        );
      },
      routes: [
        // Profile Screen
        GoRoute(
          name: Str.profileScreenRouteName,
          path: Str.profileScreenRoutePath,
          builder: _profileScreenBuilder,
          routes: [
            // Profile's Details Screen
            GoRoute(
              name: Str.detailsProfileScreenRouteName,
              path: Str.detailsScreenRoutePath,
              pageBuilder: _detailsScreenBuilder,
            ),
          ],
        ),
      ],
    ),

    // Help Screen
    GoRoute(
      name: Str.helpScreenRouteName,
      path: Str.helpScreenRoutePath,
      builder: _helpScreenBuilder,
    ),
  ],

  // Error Screen
  errorBuilder: (context, state) {
    return ErrorRoute();
  },
);

/// Screen builders

Widget _exploreScreenBuilder(BuildContext context, GoRouterState state) {
  return _buildScaffoldAppBarBodies(
    context: context,
    masterBody: ExploreBody(
      // interests: context.select<ExploreViewModel, List<InterestModel>>(
      //   (exploreViewModel) => exploreViewModel.interests,
      // ),
      // interests: context.watch<ExploreViewModel>().interests,
      onTapInterest: (interest) {
        onTapInterest(
          context: context,
          interest: interest,
          fromPath: Str.exploreScreenRoutePath,
          startEditing: false,
        );
      },
    ),
    appBarTitle: Str.exploreScreenTitle,
  );
}

Widget _chatScreenBuilder(BuildContext context, GoRouterState state) {
  return _buildScaffoldAppBarBodies(
    context: context,
    masterBody: ChatBody(
      selectedChatId: null,
      onTapChat: (Map<String, String> chatPropertiesPack) {
        onTapChat(context, chatPropertiesPack);
      },
      onSignInPressed: () => onTapSignIn(context),
    ),
    appBarTitle: Str.chatScreenTitle,
  );
}

Widget _messagesScreenBuilder(BuildContext context, GoRouterState state) {
  final chatPropertiesPack = state.extra;
  if (chatPropertiesPack == null || chatPropertiesPack is! Map) {
    print(
      '${Str.excMessageMissingChatPropertiesPack}'
      ' ${Str.excMessage_messagesScreenBuilder} - ${Str.excMessageFileRouting}'
      '\n  chatPropertiesPack: $chatPropertiesPack \n',
    );
    return ErrorRoute();
  }

  final isLargeScreen = checkLargeScreen(context);

  Widget masterBody;
  Widget? detailBody;

  Widget messagesBody = ChangeNotifierProvider(
    create:
        (BuildContext _) => MessagesViewModel(
          authRepository: context.read<AuthRepositoryImpl>(),
          chatRepository: context.read<ChatRepositoryImpl>(),
        ),
    builder: (context, child) {
      context.read<MessagesViewModel>().updateFields(
        chatPropertiesPack as Map<String, String>,
      );

      return MessagesBody();
    },
  );

  if (isLargeScreen) {
    masterBody = ChatBody(
      // Todo maybe pass 'selectedChatId'
      // selectedChatId: chatId,
      onTapChat: (Map<String, String> chatPropertiesPack) {
        onTapChat(context, chatPropertiesPack);
      },
      onSignInPressed: () => onTapSignIn(context),
    );
    detailBody = messagesBody;
  } else {
    masterBody = messagesBody;
  }

  return _buildScaffoldAppBarBodies(
    context: context,
    masterBody: masterBody,
    detailBody: detailBody,
    appBarTitle: Str.messagesScreenTitle,
  );
}

Widget _onboardingScreenBuilder(BuildContext context, GoRouterState state) {
  return Scaffold(
    body: Onboarding(
      endOnboarding: () {
        endOnboarding(context);
      },
    ),
  );
}

Widget _authScreenBuilder(BuildContext context, GoRouterState state) {
  final bool isLoggedIn = context.watch<AuthViewModel>().isLoggedIn;
  if (isLoggedIn) {
    WidgetsBinding.instance.addPostFrameCallback(
      // Todo maybe replace with `pushReplacementNamed` (check gpt 4's response).
      (Duration duration) => context.goNamed(Str.exploreScreenRouteName),
    );
  }
  return _buildScaffoldAppBarBodies(
    context: context,
    masterBody: AuthScreen(),
    appBarTitle: Str.authScreenTitle,
    isLoggedIn: isLoggedIn,
  );
}

Page<dynamic> _detailsScreenBuilder(BuildContext context, GoRouterState state) {
  return NoTransitionPage(
    child: _buildInterestDetails(context: context, state: state),
  );
}

Widget _buildInterestDetails({
  required BuildContext context,
  required GoRouterState state,
}) {
  final extra = state.extra ?? const <String, dynamic>{};
  if (extra is! Map) {
    print(
      '`extra` is not a Map. - ${state.matchedLocation}'
      ' - Check `buildInterestDetails` function.',
    );
    return ErrorRoute();
  }
  final interest =
      extra[Str.detailsScreenParamInterest] ??
      context.read<ProfileRepositoryImpl>().interestsHistory?.last;
  if (extra[Str.detailsScreenParamInterest] == null) {
    /*
    Remove the last selected interest from the list of interests history
    because it is going to be used now for back navigation and not needed anymore.
     */
    context.read<ProfileRepositoryImpl>().updateInterestsHistory(interest);
  }

  final fromPath =
      extra[Str.detailsScreenParamFromPath] ??
      GoRouterState.of(context).matchedLocation;
  final startEditing = extra[Str.detailsScreenParamStartEditing] ?? false;

  /* Todo fix. if interest is null fetch it using the provided ID. this is needed for back navigation. Or maybe store it in a view model. */
  if (interest == null ||
      interest is! InterestModel ||
      fromPath == null ||
      fromPath is! String ||
      startEditing == null ||
      startEditing is! bool) {
    print(
      '`interest` is null or not an InterestModel. Or `fromPath` is null or not a String.'
      ' - ${state.matchedLocation} - Check `buildInterestDetails` function.',
    );
    return ErrorRoute();
  }

  final bool isOwner =
      interest.userId == context.read<AuthViewModel>().currentUser?.uid;

  final Widget interestDetails = InterestDetails(
    interest: interest,
    isOwner: isOwner,
    startEditing: startEditing,
    // Todo implement
    onTapReach: () {
      onTapReach(context);
    },
  );

  final Widget masterBody;
  final String appBarTitle;
  switch (fromPath) {
    case Str.profileScreenRoutePath:
      masterBody = ProfileBody(onSignInPressed: () => onTapSignIn(context));
      appBarTitle = Str.profileScreenTitle;
      break;
    default: // case Str.exploreScreenRoutePath:
      masterBody = ExploreBody(
        onTapInterest: (interest) {
          onTapInterest(
            context: context,
            interest: interest,
            fromPath: Str.exploreScreenRoutePath,
            startEditing: startEditing,
          );
        },
      );
      appBarTitle = Str.exploreScreenTitle;
      break;
  }

  return _buildScaffoldAppBarBodies(
    context: context,
    masterBody: masterBody,
    dialogBody: interestDetails,
    detailBody: interestDetails,
    appBarTitle: appBarTitle,
  );
}

Widget _profileScreenBuilder(BuildContext context, GoRouterState state) {
  VoidCallback toggleEdit = context.read<ProfileViewModel>().toggleEdit;

  return _buildScaffoldAppBarBodies(
    context: context,
    masterBody: ProfileBody(onSignInPressed: () => onTapSignIn(context)),
    appBarTitle: Str.profileScreenTitle,
    appBarEditAction: true,
    onTapEdit: toggleEdit,
  );
}

Widget _helpScreenBuilder(BuildContext context, GoRouterState state) {
  return _buildScaffoldAppBarBodies(
    context: context,
    masterBody: HelpBody(
      onTapOnboardingGuide: () {
        onTapOnboardingGuide(context);
      },
    ),
    appBarTitle: Str.helpScreenTitle,
  );
}

Widget _buildScaffoldAppBarBodies({
  required BuildContext context,
  required Widget masterBody,
  Widget? detailBody,
  Widget? dialogBody,
  required String appBarTitle,
  bool? isLoggedIn,
  bool appBarEditAction = false,
  VoidCallback? onTapEdit,
}) {
  return ScaffoldAppBarBodies(
    masterBody: masterBody,
    detailBody: detailBody,
    dialogBody: dialogBody,
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

/// Helper functions

void goToBranchDestination(int index, StatefulNavigationShell navigationShell) {
  navigationShell.goBranch(
    index,
    initialLocation: index == navigationShell.currentIndex,
  );
}

void onTapInterest({
  required BuildContext context,
  required InterestModel interest,
  required String fromPath,
  bool startEditing = false,
}) {
  context.read<ProfileRepositoryImpl>().updateInterestsHistory(interest);

  /*
   Todo fix. when an interest is open then trying to tap another interest,
  `goNamed` and `pushReplacementNamed` changes the path (in the browser)
   but doesn't change the UI state.
  `pushNamed` doesn't change the path but does change the UI state.
   */
  context.pushNamed(
    fromPath == Str.profileScreenRoutePath
        ? Str.detailsProfileScreenRouteName
        : Str.detailsExploreScreenRouteName,
    pathParameters: {Str.detailsScreenParamId: interest.id},
    extra: {
      Str.detailsScreenParamInterest: interest,
      Str.detailsScreenParamFromPath: fromPath,
      Str.detailsScreenParamStartEditing: startEditing,
    },
  );
}

void onTapChat(BuildContext context, Map<String, String> chatPropertiesPack) {
  if (chatPropertiesPack[Str.messagesScreenParamChatId] == null) {
    print(
      '${Str.excMessageNullChatId}'
      ' ${Str.excMessageOnTapChat} - ${Str.excMessageFileRouting}'
      '\n  chatPropertiesPack: $chatPropertiesPack \n',
    );
    return;
  }

  final chatId = chatPropertiesPack[Str.messagesScreenParamChatId]!;

  // Todo maybe replace with `pushReplacementNamed` (check gpt 4's response).
  // context.go('${Str.chatScreenRoutePath}/$selectedChatId');
  context.goNamed(
    Str.messagesScreenRouteName,
    pathParameters: {Str.messagesScreenParamChatId: chatId},
    extra: chatPropertiesPack,
  );

  // else if (!isLargeScreen) {
  //   // context.push('/chat/$index');
  //   context.go('/chat/$index');
  // }
}

void onTapReach(BuildContext context) {
  // context.goNamed(Str.chatScreenRouteName);
}

void onTapOnboardingGuide(BuildContext context) {
  context.goNamed(Str.onboardingScreenRouteName);
  // context.read<PreferencesRepositoryImpl>().setIsFirstInitialization(true);
}

void endOnboarding(BuildContext context) {
  context.goNamed(Str.exploreScreenRouteName);
  // Todo maybe add 'await' before the line below
  context.read<PreferencesRepositoryImpl>().setIsFirstInitialization(false);
}

void onTapSignIn(BuildContext context) {
  context.goNamed(Str.authScreenRouteName);
}

void onTapSignOut(BuildContext context) {
  context.read<AuthViewModel>().signOut();
  context.goNamed(Str.exploreScreenRouteName);
}

void onTapEditProfile(BuildContext context) {
  // Todo maybe replace with `pushReplacementNamed` (check gpt 4's response).
  context.goNamed(Str.profileScreenRouteName);
}

void onTapHelp(BuildContext context) {
  context.goNamed(Str.helpScreenRouteName);
}
