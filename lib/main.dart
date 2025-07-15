import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'app.dart';
import 'core/preferences_repository/data/preferences_repository_impl.dart';
import 'features/auth/data/auth_repository_impl.dart';
import 'features/auth/ui/auth_viewmodel.dart';
import 'features/chat/data/chat_repository_impl.dart';
import 'features/chat/ui/chat_viewmodel.dart';
import 'features/chat/ui/messages_viewmodel.dart';
import 'features/explore/ui/explore_viewmodel.dart';
import 'features/profile/data/profile_repository_impl.dart';
import 'features/profile/ui/profile_viewmodel.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(
    MultiProvider(
      providers: [
        Provider(create: (context) => PreferencesRepositoryImpl()),
        Provider(create: (context) => AuthRepositoryImpl()),
        Provider(create: (context) => ProfileRepositoryImpl()),
        Provider(create: (context) => ChatRepositoryImpl()),
        ChangeNotifierProvider(
          create:
              (context) => ExploreViewModel(
                preferencesRepository: context.read<PreferencesRepositoryImpl>(),
                authRepository: context.read<AuthRepositoryImpl>(),
                profileRepository: context.read<ProfileRepositoryImpl>(),
              ),
        ),
        ChangeNotifierProvider(
          create:
              (context) => AuthViewModel(
                authRepository: context.read<AuthRepositoryImpl>(),
              ),
        ),
        ChangeNotifierProvider(
          create:
              (context) => ProfileViewModel(
                authRepository: context.read<AuthRepositoryImpl>(),
                profileRepository: context.read<ProfileRepositoryImpl>(),
              ),
        ),
        ChangeNotifierProvider(
          create:
              (context) => ChatViewModel(
                authRepository: context.read<AuthRepositoryImpl>(),
                chatRepository: context.read<ChatRepositoryImpl>(),
              ),
        ),
        ChangeNotifierProvider(
          create:
              (context) => MessagesViewModel(
                authRepository: context.read<AuthRepositoryImpl>(),
                chatRepository: context.read<ChatRepositoryImpl>(),
              ),
        ),
      ],
      child: ReachSkillsApp(),
    ),
  );
}
