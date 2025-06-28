import 'package:firebase_ui_localizations/firebase_ui_localizations.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'core/constants/strings.dart';
import 'core/navigation/mobile_router.dart';
import 'core/navigation/web_router.dart';

class ReachSkillsApp extends StatelessWidget {
  const ReachSkillsApp({super.key});

  // final GlobalKey<NavigatorState> rootNavigatorKey =
  //     GlobalKey<NavigatorState>(debugLabel: 'root');
  // final GlobalKey<NavigatorState> shellNavigatorKey =
  //     GlobalKey<NavigatorState>(debugLabel: 'shell');
  // final GlobalKey<NavigatorState> bottomNavigationBarKey = GlobalKey();

  // String currentUri = '';

  @override
  Widget build(BuildContext context) {
    // rebuild when screen size changes to update router
    // final double screenWidth = MediaQuery.sizeOf(context).width;
    // print('rootNavigatorKey: $rootNavigatorKey');
    // print('rootNavigatorKey.currentState: ${rootNavigatorKey.currentState}');
    // print('appShellNavigatorKey: $appShellNavigatorKey');
    // print('appShellNavigatorKey.currentState: ${appShellNavigatorKey.currentState}');


    return MaterialApp.router(
      title: Str.appTitle,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      debugShowCheckedModeBanner: false,

      localizationsDelegates: [FirebaseUILocalizations.delegate],
      supportedLocales: const [Locale('en', 'US'), Locale('tr', 'TR')],

      routerConfig: router,
    );
  }

  // GoRouter getRouterConfig(double screenWidth) {
  //   if (screenWidth < 600) {
  //     return getMobileRouter(rootNavigatorKey, shellNavigatorKey, bottomNavigationBarKey);
  //   } else if (screenWidth < 1200) {
  //     return getWebRouter(rootNavigatorKey, shellNavigatorKey);
  //   } else {
  //     return getWebRouter(rootNavigatorKey, shellNavigatorKey);
  //   }
  // }
}
