import 'package:flutter/material.dart';

import '../constants/strings.dart';
import '../theme/styles.dart';

bool checkLargeScreen(BuildContext context) {
  final isLargeScreen =
      MediaQuery.sizeOf(context).width > Styles.smallScreenWidthThreshold;
  return isLargeScreen;
}

int _calculateDaysDifference(DateTime date) {
  final now = DateTime.now();
  final difference = now.difference(date);
  return difference.inDays;
}

String _formatDaysDifference(int days) {
  if (days == 0) {
    return 'Today';
  } else if (days == 1) {
    return 'Yesterday';
  } else {
    return '$days days ago';
  }
}

String calculateDaysDifferenceAndFormat(DateTime date) {
  final daysDifference = _calculateDaysDifference(date);
  return _formatDaysDifference(daysDifference);
}

String formatDateTimeDifference(DateTime dateTime) {
  final now = DateTime.now();
  final difference = now.difference(dateTime);
  if (difference.inDays == 0) {
    return 'Today';
  } else if (difference.inDays == 1) {
    return 'Yesterday';
  } else {
    return '${dateTime.year}/${dateTime.month}/${dateTime.day}';
  }
}

extension StringExtensions on String {
  String xToSentenceCase() {
    return "${this[0].toUpperCase()}${this.substring(1)}";
  }

  String xToTitleCase() {
    return split(' ').map((word) => word.xToSentenceCase()).join(' ');
  }
}

String? textValidator(String? value) {
  return value == null || value.isEmpty ? Str.required : null;
}
