import 'package:flutter/material.dart';
import 'package:reach_skills/features/common/widgets/rs_popup_menu_button.dart';

import 'rs_app_bar.dart';

class ScaffoldAppBar extends StatelessWidget {
  const ScaffoldAppBar({
    super.key,
    required this.body,
    required this.appBarTitle,
    required this.isLoggedIn,
  });

  final Widget body;
  final String appBarTitle;
  final bool isLoggedIn;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: body),
      appBar: rsAppBar(
        context: context,
        title: appBarTitle,
        actions: [RsPopupMenuButton(isLoggedIn: isLoggedIn)],
      ),
    );
  }
}
