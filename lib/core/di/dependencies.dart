import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:reach_skills/core/preferences_repository/data/preferences_repository_impl.dart';
import 'package:reach_skills/features/auth/data/auth_repository_impl.dart';
import 'package:reach_skills/features/auth/domain/auth_repository.dart';
import 'package:reach_skills/features/auth/domain/use_cases/get_auth_session_use_case.dart';
import 'package:reach_skills/features/auth/domain/use_cases/sign_out_use_case.dart';
import 'package:reach_skills/features/chat/data/chat_repository_impl.dart';
import 'package:reach_skills/features/common/data/temp_nav_history.dart';
import 'package:reach_skills/features/profile/data/profile_repository_impl.dart';

/// Configure dependencies for remote data.
/// This dependency list uses repositories that connect to a remote server.
List<SingleChildWidget> get remoteProviders {
  return [
    Provider(create: (context) => PreferencesRepositoryImpl()),
    Provider<AuthRepository>(create: (context) => AuthRepositoryImpl()),
    Provider(
      create:
          (context) => ProfileRepositoryImpl(
            authRepository: context.read<AuthRepository>(),
          ),
    ),
    Provider(lazy: true, create: (context) => ChatRepositoryImpl()),
    Provider(create: (context) => TempNavHistory()),

    // Use-cases
    ...sharedUseCaseProviders,
  ];
}

/// Shared providers for all configurations
List<SingleChildWidget> get sharedUseCaseProviders {
  return [
    Provider(
      create:
          (context) => GetAuthSessionUseCase(context.read<AuthRepository>()),
    ),
    Provider(
      create: (context) => SignOutUseCase(context.read<AuthRepository>()),
    ),
  ];
}
