import 'package:flutter/material.dart';

import '../../features/common/data/interest_model.dart';
import '../../features/common/widgets/interest_details.dart';
import '../constants/strings.dart';
import '../theme/styles.dart';

extension WidgetFullWidth on Widget {
  Widget withFullWidth() => SizedBox(width: double.infinity, child: this);
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

String? textValidator(String? value) {
  return value == null || value.isEmpty ? Str.required : null;
}

void showDetailsScreenDialog(
  BuildContext context, {
  required InterestModel? interest,
  void Function()? onTapReach,
  void Function(InterestModel interest)? onTapSave,
  bool startEditing = false,
}) {
  showAdaptiveDialog(
    context: context,
    builder: (context) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Styles.borderRadius),
        ),
        backgroundColor: Styles.rsDefaultSurfaceColor,
        child: InterestDetails(
          interest: interest,
          onTapReach: onTapReach,
          onTapSave: onTapSave,
          startEditing: startEditing,
        ),
      );
    },
  );
}

void showSnackBarMessage(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
}
