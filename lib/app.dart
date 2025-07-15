import 'package:firebase_ui_localizations/firebase_ui_localizations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reach_skills/features/explore/ui/explore_viewmodel.dart';

import 'core/constants/strings.dart';
import 'core/routing/routing.dart';
import 'core/theme/theme.dart';

class ReachSkillsApp extends StatelessWidget {
  const ReachSkillsApp({super.key});

  @override
  Widget build(BuildContext context) {
    final brightness = View.of(context).platformDispatcher.platformBrightness;
    final textTheme = Theme.of(context).textTheme;
    MaterialTheme theme = MaterialTheme(textTheme);
    bool? isFirstInitialization =
        context.read<ExploreViewModel>().isFirstInitialization;

    if (isFirstInitialization == null) {
      return Center(child: const CircularProgressIndicator());
    }

    return MaterialApp.router(
      title: Str.appTitle,
      theme: brightness == Brightness.light ? theme.light() : theme.dark(),
      debugShowCheckedModeBanner: false,

      localizationsDelegates: [FirebaseUILocalizations.delegate],
      supportedLocales: const [Locale('en', 'US'), Locale('tr', 'TR')],

      routerConfig: getRouter(isFirstInitialization),
    );
  }
}
