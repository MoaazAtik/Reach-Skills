import 'package:flutter/material.dart';

import '../theme/styles.dart';

bool checkLargeScreen(BuildContext context) {
  final isLargeScreen =
      MediaQuery.sizeOf(context).width > Styles.smallScreenWidthThreshold;
  return isLargeScreen;
}
