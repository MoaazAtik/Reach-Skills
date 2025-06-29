import 'package:firebase_ui_localizations/firebase_ui_localizations.dart';
import 'package:flutter/material.dart';

import 'core/constants/strings.dart';
import 'core/routing/routing.dart';

class ReachSkillsApp extends StatelessWidget {
  const ReachSkillsApp({super.key});

  @override
  Widget build(BuildContext context) {
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
}
