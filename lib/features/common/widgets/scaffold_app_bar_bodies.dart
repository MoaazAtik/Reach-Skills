import 'package:flutter/material.dart';
import 'package:reach_skills/features/common/widgets/rs_app_bar.dart';
import 'package:reach_skills/features/common/widgets/rs_popup_menu_button.dart';

class ScaffoldAppBarBodies extends StatelessWidget {
  const ScaffoldAppBarBodies({
    super.key,
    required this.masterBody,
    this.detailBody,
    required this.appBarTitle,
    required this.isLoggedIn,
  });

  final Widget masterBody;
  final Widget? detailBody;
  final String appBarTitle;
  final bool isLoggedIn;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Row(
          children: [
            Expanded(child: masterBody),
            if (detailBody != null) // ie, large screen
              Expanded(child: detailBody!),
          ],
        ),
      ),
      appBar: rsAppBar(
        context: context,
        title: appBarTitle,
        actions: [RsPopupMenuButton(isLoggedIn: isLoggedIn)],
      ),
    );
  }
}
