import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:reach_skills/features/common/widgets/rs_navigation_drawer.dart';

import '../../features/common/widgets/rs_app_bar.dart';
import '../../features/common/widgets/rs_bottom_navigation_bar.dart';
import '../../features/explore/ui/explore_body.dart';
import '../constants/strings.dart';

final router = GoRouter( // Works
  navigatorKey: GlobalKey<NavigatorState>(debugLabel: 'root'), // Is it needed?
  initialLocation: Str.exploreScreenRoutePath,
  debugLogDiagnostics: true,
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (
          BuildContext context,
          GoRouterState state,
          StatefulNavigationShell navigationShell,
      ) {
        final isLargeScreen = MediaQuery.sizeOf(context).width > 600;

        return Scaffold(
          body: Row(
            children: [
              if (isLargeScreen)
                RsNavigationRail(),
              Expanded(child: navigationShell),
            ],
          ),
          bottomNavigationBar: isLargeScreen ? null : RsBottomNavigationBar(
            navigationShell: navigationShell,
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
              path: '/chat',
              builder: (BuildContext context, GoRouterState state) {
                return ChatBody();
              },
              routes: [
                GoRoute(
                  // name: Str.chatScreenRouteName,
                  // path: Str.chatScreenRoutePath,
                  path: ':id',
                  builder: (BuildContext context, GoRouterState state) {
                    final chatId = state.pathParameters['id'];
                    print('chatId: $chatId');
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

class ChatBody extends StatelessWidget {

  final String? selectedChatId;

  const ChatBody({super.key, this.selectedChatId});

  @override
  Widget build(BuildContext context) {
    final isLargeScreen = MediaQuery.sizeOf(context).width > 600;
    print('selectedChatId: $selectedChatId');

    return Scaffold(
      body: Row(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: 10,
              itemBuilder: (context, index) => ListTile(
                title: Text('Chat $index'),
                onTap: () {
                  if (isLargeScreen) {
                    context.go('/chat/$index');
                    // context.push('/chat/$index');
                    print('index: $index');
                  } else {
                    context.push('/chat/$index');
                    print('index: $index');

                    // context.push('$index');
                  }
                },
              ),
              // onTap: (id) {
              //   if (isLargeScreen) {
              //     context.go('/chat/$id');
              //   } else {
              //     context.push('/chat/$id');
              //   }
              // },
            ),
          ),
          if (isLargeScreen && selectedChatId != null)
            Expanded(
              child: ListView.builder(
                itemCount: 10,
                itemBuilder: (context, index) =>
                    ListTile(
                      title: Text('chatId: $selectedChatId,\n Message $index'),
                    ),
                // child: ChatMessagesScreen(chatId: selectedChatId!),
              ),
            )
           else if (!isLargeScreen && selectedChatId != null)
            Expanded( // Todo replace with MessageScreen
              child: ListView.builder(
                itemCount: 10,
                itemBuilder: (context, index) =>
                    ListTile(
                      title: Text('smallll\n chatId: $selectedChatId,\n Message $index'),
                    ),
                // child: ChatMessagesScreen(chatId: selectedChatId!),
              ),
            )

        ],
      ),
      appBar: rsAppBar(
        title: Str.chatScreenTitle,
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

    // return Scaffold(
    //   body: Center(child: Text(Str.chatScreenTitle)),
    //   appBar: rsAppBar(
    //     title: Str.chatScreenTitle,
    //     actions: [
    //       Padding(
    //         padding: const EdgeInsets.only(right: 8.0),
    //         child: IconButton(
    //           onPressed: () {},
    //           icon: const Icon(Icons.more_vert_rounded),
    //         ),
    //       ),
    //     ],
    //   ),
    // );
  }
}



GoRouter getMobileRouter(
  GlobalKey<NavigatorState> rootNavigatorKey,
  GlobalKey<NavigatorState> shellNavigatorKey,
  GlobalKey bottomNavigatorKey,
) {
  return GoRouter(
    // navigatorKey: rootNavigatorKey,
    initialLocation: Str.exploreScreenRoutePath,
    debugLogDiagnostics: true,
    routes: [
      StatefulShellRoute.indexedStack(
        // key: shellNavigatorKey,
        builder: (
          BuildContext context,
          GoRouterState state,
          StatefulNavigationShell navigationShell,
        ) {
          return Scaffold(
            // key:bottomNavigatorKey,
            body: navigationShell,
            // bottomNavigationBar: rsNavigationBar(context, navigationShell), // TODO remove context
            bottomNavigationBar: RsBottomNavigationBar(
                key: bottomNavigatorKey,
                navigationShell: navigationShell),
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
                  return Scaffold(
                    body: Center(child: Text(Str.chatScreenTitle)),
                    appBar: rsAppBar(
                      title: Str.chatScreenTitle,
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
}
