import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/strings.dart';

class ErrorRoute extends StatelessWidget {
  const ErrorRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              Str.screenNotFoundMessage,
              style: TextStyle(color: Colors.amber),
            ),
            ElevatedButton(
              onPressed: () => context.go(Str.exploreScreenRoutePath),
              child: Text(Str.exploreScreenRouteName),
            ),
          ],
        ),
      ),
    );
  }
}
