import 'package:firebase_ui_localizations/firebase_ui_localizations.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'core/constants/strings.dart';
import 'core/navigation/mobile_router.dart';
import 'core/navigation/web_router.dart';

class ReachSkillsApp extends StatelessWidget {
  const ReachSkillsApp({super.key});

  @override
  Widget build(BuildContext context) {
    // rebuild when screen size changes to update router
    final double screenWidth = MediaQuery.sizeOf(context).width;

    return MaterialApp.router(
      title: Str.appTitle,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      debugShowCheckedModeBanner: false,

      localizationsDelegates: [FirebaseUILocalizations.delegate],
      supportedLocales: const [Locale('en', 'US'), Locale('tr', 'TR')],

      routerConfig: getRouterConfig(screenWidth),
    );
  }

  GoRouter getRouterConfig(double screenWidth) {
    if (screenWidth < 600) {
      return mobileRouter;
    } else if (screenWidth < 1200) {
      return webRouter;
    } else {
      return webRouter;
    }
  }
}
