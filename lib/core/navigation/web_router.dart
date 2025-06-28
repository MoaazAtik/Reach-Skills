import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../features/common/widgets/rs_app_bar.dart';
import '../../features/common/widgets/rs_bottom_navigation_bar.dart';
import '../../features/common/widgets/rs_navigation_drawer.dart';
import '../../features/explore/ui/explore_body.dart';
import '../constants/strings.dart';

GoRouter getWebRouter(GlobalKey<NavigatorState> appShellNavigatorKey,GlobalKey<NavigatorState> rootNavigatorKey) {
  return GoRouter(
    // navigatorKey: rootNavigatorKey,
    initialLocation: Str.exploreScreenRoutePath,
    // debugLogDiagnostics: true,
    routes: [
      ShellRoute(
        // navigatorKey: appShellNavigatorKey,
        builder: (BuildContext context, GoRouterState state, Widget child) {
          return Scaffold(
            body: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                // rsNavigationDrawer(context),
                rsNavigationRail(context),
                Expanded(child: child),
              ],
            ),
            // appBar: rsAppBar(title: 'my title'),
            // drawer: rsNavigationDrawer(context),
            // bottomNavigationBar: rsNavigationBar(context),
          );
        },
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
          GoRoute(
            name: Str.chatScreenRouteName,
            path: Str.chatScreenRoutePath,
            builder: (BuildContext context, GoRouterState state) {
              return Scaffold(
                body: Center(
                  child: Text(
                    Str.chatScreenRouteName,
                    style: TextStyle(color: Colors.amber),
                  ),
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
            },
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
