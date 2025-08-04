import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:reach_skills/core/utils/utils.dart';
import 'package:reach_skills/features/common/widgets/rs_app_bar.dart';
import 'package:reach_skills/features/common/widgets/rs_popup_menu_button.dart';

import '../../../core/constants/strings.dart';
import 'declarative_dialog_overlay.dart';

class ScaffoldAppBarBodies extends StatelessWidget {
  const ScaffoldAppBarBodies({
    super.key,
    required this.masterBody,
    this.detailBody,
    this.dialogBody,
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
  final Widget? dialogBody;
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
      body:
          (checkLargeScreen(context)) // ie, large screen
              ? SafeArea(
                child: Row(
                  children: [
                    Expanded(child: masterBody),
                    if (detailBody != null) Expanded(child: detailBody!),
                  ],
                ),
              )
              : Stack(
                children: [
                  masterBody.withFullSize(),

                  if (detailBody != null && dialogBody == null)
                    detailBody!.withFullSize(),

                  if (dialogBody != null)
                    DeclarativeDialogOverlay(
                      onDismiss: () {
                        // context.go('/');
                        if (context.canPop()) {
                          context.pop();
                        }
                      },
                      child: dialogBody!,
                    ),
                ],
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
              '${Str.excMessageScaffoldAppBarBodies} - ${Str.excMessageNullAppBarActions}',
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
