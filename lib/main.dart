import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:reach_skills/features/auth/domain/use_cases/get_auth_session_use_case.dart';
import 'package:reach_skills/features/auth/domain/use_cases/sign_out_use_case.dart';
import 'package:reach_skills/features/common/data/temp_nav_history.dart';

import 'app.dart';
import 'core/preferences_repository/data/preferences_repository_impl.dart';
import 'features/auth/data/auth_repository_impl.dart';
import 'features/chat/data/chat_repository_impl.dart';
import 'features/profile/data/profile_repository_impl.dart';
import 'firebase_options.dart';

void main() async {
  await dotenv.load(fileName: ".env");

  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(
    MultiProvider(
      providers: [
        Provider(create: (context) => PreferencesRepositoryImpl()),
        Provider(create: (context) => AuthRepositoryImpl()),
        Provider(
          create:
              (context) => ProfileRepositoryImpl(
                authRepository: context.read<AuthRepositoryImpl>(),
              ),
        ),
        Provider(create: (context) => ChatRepositoryImpl()),
        Provider(create: (context) => TempNavHistory()),

        // Use-cases
        Provider(
          create:
              (context) =>
                  GetAuthSessionUseCase(context.read<AuthRepositoryImpl>()),
        ),
        Provider(
          create:
              (context) => SignOutUseCase(context.read<AuthRepositoryImpl>()),
        ),
      ],
      child: const ReachSkillsApp(),
    ),
  );
}
