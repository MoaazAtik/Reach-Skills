import 'package:firebase_ui_localizations/firebase_ui_localizations.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:reach_skills/features/explore/ui/explore_viewmodel.dart';

import 'core/constants/strings.dart';
import 'core/routing/routing.dart';
import 'core/theme/theme.dart';

/*
- Memoizing 'late final GoRouter _router;' either in or out of _ReachSkillsAppState is what reduced statefulShellRoute and NavigationShellScaffold rebuilds.
It also removed the unwanted screen blinking when rebuilding:
 */

/* Todo
1. Avoid unnecessary logic inside build()
2. Memoize GoRouter, themes, and expensive objects
3. Use StatefulWidget for app root
 */

class ReachSkillsApp extends StatefulWidget {
  const ReachSkillsApp({super.key});

  @override
  State<ReachSkillsApp> createState() => _ReachSkillsAppState();
}

class _ReachSkillsAppState extends State<ReachSkillsApp> {
  @override
  void initState() {
    super.initState();
    _router = getRouter(false);
  }

  late final GoRouter _router;

  @override
  Widget build(BuildContext context) {
    final brightness = View.of(context).platformDispatcher.platformBrightness;
    final textTheme = Theme.of(context).textTheme;
    MaterialTheme theme = MaterialTheme(textTheme);
    // Todo uncomment and fix infinite loading
    // bool? isFirstInitialization = context.select<ExploreViewModel, bool?>((
    //   viewModel,
    // ) {
    //   return viewModel.isFirstInitialization;
    // });
    //
    // if (isFirstInitialization == null) {
    //   return Center(child: const CircularProgressIndicator());
    // }
    print(
      'Key: ${widget.key} | Type: $runtimeType | Hash: ${identityHashCode(this)} ie, $hashCode',
    );

    return MaterialApp.router(
      title: Str.appTitle,
      theme: brightness == Brightness.light ? theme.light() : theme.dark(),

      // debugShowMaterialGrid: true,
      // showSemanticsDebugger: true,
      debugShowCheckedModeBanner: false,
      localizationsDelegates: [FirebaseUILocalizations.delegate],
      supportedLocales: const [Locale('en', 'US'), Locale('tr', 'TR')],

      routerConfig: _router,
    );
  }
}
