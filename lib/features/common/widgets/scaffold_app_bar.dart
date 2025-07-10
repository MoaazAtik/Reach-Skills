import 'package:flutter/material.dart';
import 'package:reach_skills/features/common/widgets/rs_popup_menu_button.dart';

import '../../../core/theme/styles.dart';
import 'rs_app_bar.dart';

class ScaffoldAppBar extends StatelessWidget {
  const ScaffoldAppBar({
    super.key,
    required this.body,
    required this.appBarTitle,
    required this.isLoggedIn,
    this.appBarEditAction = false,
  });

  final Widget body;
  final String appBarTitle;
  final bool isLoggedIn;
  final bool appBarEditAction;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: body),
      appBar: rsAppBar(
        context: context,
        title: appBarTitle,
        actions: [
          if (!appBarEditAction) RsPopupMenuButton(isLoggedIn: isLoggedIn),
          if (appBarEditAction)
            IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {
                print('Edit button pressed');
              },
            ),
        ],
      ),
    );
  }
}
