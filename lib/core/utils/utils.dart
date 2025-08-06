import 'package:flutter/material.dart';

import '../constants/strings.dart';
import '../theme/styles.dart';

extension WidgetExtensions on Widget {
  /// For widgets with **Bounded** width like `Columns`
  Widget withFullWidth() => SizedBox(width: double.infinity, child: this);

  /// For widgets with **Unbounded** horizontal axis like `Rows`
  Widget withFiniteMaxWidth({
    required BuildContext context,
    double ratio = 1.0,
  }) => SizedBox(width: MediaQuery.sizeOf(context).width * ratio, child: this);

  /*
  Widget withFullSize() => Positioned.fill(child: this);
  OR
  */
  Widget withFullSize() => SizedBox.expand(child: this);

  /*
  Widget alignCenter() => Center(child: this);
  OR
  */
  Widget alignCenter() => Align(alignment: Alignment.center, child: this);
}

bool checkLargeScreen(BuildContext context) {
  final isLargeScreen =
      MediaQuery.sizeOf(context).width > Styles.smallScreenWidthThreshold;
  return isLargeScreen;
}

int _calculateDaysDifference(DateTime? dateTime, int? dateInMillis) {
  DateTime tempDate;
  if (dateTime != null) {
    tempDate = dateTime;
  } else if (dateInMillis != null) {
    tempDate = DateTime.fromMillisecondsSinceEpoch(dateInMillis);
  } else {
    throw Exception(
      'dateTime or dateInMilliseconds must be provided to calculateDaysDifference function in utils.dart',
    );
  }
  final now = DateTime.now();
  final difference = now.difference(tempDate);
  return difference.inDays;
}

String _formatDaysDifference(int days) {
  if (days == 0) {
    return Str.today;
  } else if (days == 1) {
    return Str.yesterday;
  } else {
    return '$days ${Str.daysAgo}';
  }
}

/// Provide either dateTime or dateInMillis to calculate the difference in days between the provided date and today.
String calculateDaysDifferenceAndFormat({
  DateTime? dateTime,
  int? dateInMillis,
}) {
  final daysDifference = _calculateDaysDifference(dateTime, dateInMillis);
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
    return "${this[0].toUpperCase()}${substring(1)}";
  }

  String xToTitleCase() {
    return split(' ').map((word) => word.xToSentenceCase()).join(' ');
  }
}

String? textValidator(String? value, {String errorMessage = Str.required}) {
  return value == null || value.isEmpty ? errorMessage : null;
}

void showSnackBarMessage(
  BuildContext context,
  String message, {
  String? actionLabel,
  VoidCallback? onActionPressed,
}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      action: SnackBarAction(
        label: actionLabel ?? '',
        onPressed: onActionPressed ?? () {},
      ),
    ),
  );
}
