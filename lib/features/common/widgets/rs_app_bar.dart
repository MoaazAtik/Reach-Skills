import 'package:flutter/material.dart';

AppBar rsAppBar({
  required String title,
  Widget? leading,
  List<Widget>? actions,
  required BuildContext context,
}) {
  return AppBar(
    automaticallyImplyLeading: false,
    title: Text(
      title,
      style: Theme.of(
        context,
      ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
    ),
    centerTitle: true,
    leading: leading,
    actions: actions,
  );
}
