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
    this.onTapSignIn,
    this.onTapSignOut,
    this.onTapEditProfile,
    this.onTapHelp,
    this.appBarEditAction = false,
    this.onTapEdit,
  });

  final Widget masterBody;
  final Widget? detailBody;
  final String appBarTitle;
  final bool isLoggedIn;
  final VoidCallback? onTapSignIn;
  final VoidCallback? onTapSignOut;
  final VoidCallback? onTapEditProfile;
  final VoidCallback? onTapHelp;

  final bool appBarEditAction;
  final VoidCallback? onTapEdit;

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
        actions: [
          if (!appBarEditAction && (onTapSignIn == null) ||
              (onTapSignOut == null) ||
              (onTapEditProfile == null) ||
              (onTapHelp == null))
            throw Exception(
              'ScaffoldAppBarBodies: appBarEditAction is false but onTapSignIn, onTapSignOut, onTapEditProfile, or onTapHelp is null. They are required for the popup menu button (RsPopupMenuButton).',
            ),
          if (!appBarEditAction)
            RsPopupMenuButton(
              isLoggedIn: isLoggedIn,
              onTapSignIn: onTapSignIn!,
              onTapSignOut: onTapSignOut!,
              onTapEditProfile: onTapEditProfile!,
              onTapHelp: onTapHelp!,
            ),
          if (appBarEditAction)
            IconButton(icon: Icon(Icons.edit_outlined), onPressed: onTapEdit),
        ],
      ),
    );
  }
}
