import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reach_skills/app.dart';
import 'package:reach_skills/firebase_options.dart';

import 'core/di/dependencies.dart';

/// Production config entry point.
/// Launch with `flutter run --target lib/main_production.dart`.
/// Uses remote data from a server.
void main() async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(
    MultiProvider(providers: remoteProviders, child: const ReachSkillsApp()),
  );
}
