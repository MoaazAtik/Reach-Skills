import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'app.dart';
import 'features/auth/data/auth_repository_impl.dart';
import 'features/auth/ui/auth_viewmodel.dart';
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
        Provider(create: (context) => ProfileRepositoryImpl()),
        ChangeNotifierProvider(
          create:
              (context) => ExploreViewModel(
                profileRepository: context.read<ProfileRepositoryImpl>(),
              ),
        ),
        ChangeNotifierProvider(
          create:
              (context) => AuthViewModel(authRepository: AuthRepositoryImpl()),
        ),
        ChangeNotifierProvider(
          create:
              (context) => ProfileViewModel(
                profileRepository: context.read<ProfileRepositoryImpl>(),
              ),
        ),
      ],
      child: SkillSwapApp(),
    ),
  );
}
