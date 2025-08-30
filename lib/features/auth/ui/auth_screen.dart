import 'dart:io';

import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:firebase_ui_oauth_google/firebase_ui_oauth_google.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/strings.dart';
import 'auth_viewmodel.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authViewModel = context.watch<AuthViewModel>();
    // Todo perhaps remove this isLoggedIn
    // and use the one passed to the widget by routing
    final isLoggedIn = authViewModel.isLoggedIn;

    final authError = authViewModel.authError;

    if (authError != null) {
      return Center(child: Text('${Str.error}: $authError'));
    }

    String googleClientId =
        kIsWeb
            ? dotenv.env['GOOGLE_CLIENT_ID_WEB'] ?? ''
            : Platform.isIOS
            ? dotenv.env['GOOGLE_CLIENT_ID_IOS'] ?? ''
            : '';

    return SignInScreen(
      providers: [
        EmailAuthProvider(),
        GoogleProvider(clientId: googleClientId),
      ],
      showPasswordVisibilityToggle: true,
      oauthButtonVariant: OAuthButtonVariant.icon_and_text,
    );
  }
}
