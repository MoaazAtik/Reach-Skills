import 'package:flutter/material.dart';

import '../../../core/theme/styles.dart';

Widget onboardingProgressChip(Color backgroundColor) {
  return Container(
    width: Styles.progressChipHeight,
    height: Styles.progressChipHeight,
    decoration: BoxDecoration(shape: BoxShape.circle, color: backgroundColor),
  );
}
