import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'app.dart';
import 'features/auth/data/auth_repository_impl.dart';
import 'features/auth/ui/auth_viewmodel.dart';
import 'features/home/data/home_repository_impl.dart';
import 'features/home/ui/home_viewmodel.dart';
import 'features/profile/data/profile_repository_impl.dart';
import 'features/profile/ui/edit_profile_viewmodel.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create:
              (context) => HomeViewModel(homeRepository: HomeRepositoryImpl()),
        ),
        ChangeNotifierProvider(
          create:
              (context) => AuthViewModel(authRepository: AuthRepositoryImpl()),
        ),
        Provider(
          create:
              (context) =>
                  EditProfileViewModel(profileRepository: ProfileRepositoryImpl()),
        ),
      ],
      child: SkillSwapApp(),
    ),
  );
}
