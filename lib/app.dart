import 'package:firebase_ui_localizations/firebase_ui_localizations.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:reach_skills/core/preferences_repository/data/preferences_repository_impl.dart';

import 'core/constants/strings.dart';
import 'core/routing/routing.dart';
import 'core/theme/theme.dart';

class ReachSkillsApp extends StatefulWidget {
  const ReachSkillsApp({super.key});

  @override
  State<ReachSkillsApp> createState() => _ReachSkillsAppState();
}

class _ReachSkillsAppState extends State<ReachSkillsApp> {
  @override
  void initState() {
    super.initState();
    _defineRouter();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    /*
     No need to call `setState` because changes in `MediaQuery` and `Theme`
     will trigger `build` automatically after calling `didChangeDependencies`.
     */
    _brightness = MediaQuery.of(context).platformBrightness;
    _textTheme = Theme.of(context).textTheme;
    _theme = MaterialTheme(_textTheme);
  }

  /*
   Memoizing 'GoRouter' reduced statefulShellRoute and NavigationShellScaffold
   rebuilds (especially in Dev mode).
   It also removed the unwanted screen blinking when rebuilding.
   */
  GoRouter? _router;
  late Brightness _brightness;
  late TextTheme _textTheme;
  late MaterialTheme _theme;

  @override
  Widget build(BuildContext context) {
    if (_router == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return MaterialApp.router(
      title: Str.appTitle,
      theme: _brightness == Brightness.light ? _theme.light() : _theme.dark(),

      // debugShowMaterialGrid: true,
      // showSemanticsDebugger: true,
      debugShowCheckedModeBanner: false,

      localizationsDelegates: [FirebaseUILocalizations.delegate],
      supportedLocales: const [Locale('en', 'US'), Locale('tr', 'TR')],

      routerConfig: _router,
    );
  }

  Future<void> _defineRouter() async {
    bool isFirstInitialization = await context
        .read<PreferencesRepositoryImpl>()
        .isFirstInitialization()
        .timeout(
          const Duration(seconds: 3),
          onTimeout:
              () => PreferencesRepositoryImpl.defaultIsFirstInitialization,
        );

    /*
    Prevent setState after dispose
     */
    if (!mounted) {
      print('${Str.excMessageNotMounted} - $this');
      return;
    }

    setState(() => _router = getRouter(isFirstInitialization));
  }
}
