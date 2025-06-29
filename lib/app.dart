import 'package:firebase_ui_localizations/firebase_ui_localizations.dart';
import 'package:flutter/material.dart';

import 'core/theme/theme.dart';
import 'core/constants/strings.dart';
import 'core/routing/routing.dart';

class ReachSkillsApp extends StatelessWidget {
  const ReachSkillsApp({super.key});

  @override
  Widget build(BuildContext context) {
    final brightness = View.of(context).platformDispatcher.platformBrightness;

    TextTheme textTheme = createTextTheme(context, "Plus Jakarta Sans", "Plus Jakarta Sans");

    MaterialTheme theme = MaterialTheme(textTheme);

    return MaterialApp.router(
      title: Str.appTitle,
      theme: brightness == Brightness.light ? theme.light() : theme.dark(),
      // theme: ThemeData(
      //   colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      // ),
      debugShowCheckedModeBanner: false,

      localizationsDelegates: [FirebaseUILocalizations.delegate],
      supportedLocales: const [Locale('en', 'US'), Locale('tr', 'TR')],

      routerConfig: router,
    );
  }
}


TextTheme createTextTheme(
    BuildContext context, String bodyFontString, String displayFontString) {
  TextTheme baseTextTheme = Theme.of(context).textTheme;
  TextTheme bodyTextTheme = GoogleFonts.getTextTheme(bodyFontString, baseTextTheme);
  TextTheme displayTextTheme =
  GoogleFonts.getTextTheme(displayFontString, baseTextTheme);
  TextTheme textTheme = displayTextTheme.copyWith(
    bodyLarge: bodyTextTheme.bodyLarge,
    bodyMedium: bodyTextTheme.bodyMedium,
    bodySmall: bodyTextTheme.bodySmall,
    labelLarge: bodyTextTheme.labelLarge,
    labelMedium: bodyTextTheme.labelMedium,
    labelSmall: bodyTextTheme.labelSmall,
  );
  return textTheme;
}