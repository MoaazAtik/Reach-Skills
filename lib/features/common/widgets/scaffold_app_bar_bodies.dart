import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:reach_skills/core/utils/utils.dart';
import 'package:reach_skills/features/common/widgets/rs_app_bar.dart';
import 'package:reach_skills/features/common/widgets/rs_popup_menu_button.dart';

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
    // if (widget.dialogBody != null) {
    //   print('g\n\n\nn\n');
    //   WidgetsBinding.instance.addPostFrameCallback(
    //     (Duration duration) => showAdaptiveDialog(
    //       context: context,
    //       builder: (BuildContext context) => Dialog(
    //         shape: RoundedRectangleBorder(
    //           borderRadius: BorderRadius.circular(Styles.borderRadius),
    //         ),
    //         backgroundColor: Styles.rsDefaultSurfaceColor,
    //         child: widget.dialogBody,
    //       ),
    //     ),
    //   );
    // }

    return Scaffold(
      body:(checkLargeScreen(context)) ? SafeArea(
        child: Row(
          children: [
            Expanded(child: masterBody),
            // if (widget.detailBody != null && checkLargeScreen(context)) // ie, large screen
            //
            if (detailBody != null) // ie, large screen
              Expanded(child: detailBody!),
          ],
        ),
      ) : Stack(
        children: [
          masterBody,
          if (detailBody != null) // ie, small screen
            DeclarativeDialogOverlay(
              onDismiss: () {
                // context.go('/');
                if (context.canPop()) {
                  context.pop();
                }
              },
              child: detailBody!,
            ) ,
        ]
      ),
      // floatingActionButton: (!checkLargeScreen(context) && widget.detailBody != null)
      //     ? Builder( // Do I need this builder (?)
      //   builder: (dialogContext) =>
      //       DeclarativeDialogOverlay(
      //     onDismiss: () => context.go('/'),
      //     child: widget.detailBody!,
      //   ),
      // )
      //     : null,
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

// Trials as a Stateful widget using imperative showDialog() instead of the declarative approach using DeclarativeDialogOverlay()

// bool _dialogShown = false;
// BuildContext? _dialogContext;

// @override
// void didChangeDependencies() {
//   super.didChangeDependencies();
//
//   // final isDetailsRoute = GoRouterState.of(context).uri.toString().contains('details');
//   //
//   // // Dismiss dialog manually when route changes and dialog is open
//   // if (!isDetailsRoute && _dialogContext != null) {
//   //   print('!isDetailsRoute && _dialogContext != null');
//   //   // if (_dialogContext!.canPop())
//   //   WidgetsBinding.instance.addPostFrameCallback((_) {
//   //     Navigator.of(_dialogContext!).maybePop();
//   //     // context!.pop();
//   //     _dialogContext = null;
//   //     _dialogShown = false;
//   //   });
//   //   // context.pop();
//   // }
//
//   final isLargeScreen = MediaQuery.sizeOf(context).width >= 600;
//
//   // if (isLargeScreen && _dialogShown) {
//   //   WidgetsBinding.instance.addPostFrameCallback((_) {
//   //     if (mounted) {
//   //       context.go('/');
//   //     }
//   //   });
//   // }
//   // print(GoRouterState.of(context).uri.toString());
//   if (!isLargeScreen && !_dialogShown && GoRouterState.of(context).uri.toString().contains('details')) {
//   // if (!isLargeScreen && !_dialogShown) {
//   //   print('_dialogShown b: ${_dialogShown}');
//     _dialogShown = true;
//     // print('_dialogShown a: ${_dialogShown}');
//
//     // Delay dialog display until after the current frame
//     WidgetsBinding.instance.addPostFrameCallback((_) async {
//       // print('mounted: ${mounted}');
//       if (!mounted) return;
//
//       await showDialog(
//         context: context,
//         builder: (dialogContext) {
//           _dialogContext = dialogContext;
//           return Dialog(
//             child: widget.dialogBody,
//           );
//         },
//       );
//
//       // After dialog is dismissed, navigate back to /explore
//       if (mounted && GoRouterState.of(context).uri.toString().contains('details')
//           && context.canPop()) {
//         // context.go(Str.exploreScreenRoutePath);
//         context.pop();
//       }
//
//       _dialogContext = null;
//       _dialogShown = false;
//     });
//   }
//
// }

// @override
// void didUpdateWidget(covariant ScaffoldAppBarBodies oldWidget) {
//   super.didUpdateWidget(oldWidget);
//
//   final isDetailsRoute = GoRouterState.of(context).uri.toString().contains('details');
//
//   // Dismiss dialog manually when route changes and dialog is open
//   if (!isDetailsRoute && _dialogContext != null) {
//     // print('!isDetailsRoute && _dialogContext != null');
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       // if (_dialogContext != null && Navigator.of(_dialogContext!).canPop()) {
//       // if (_dialogContext != null) {
//         Navigator.of(_dialogContext!).maybePop().then((v) => print(v));
//         _dialogContext = null;
//         _dialogShown = false;
//       // }
//     });
//     // Navigator.of(_dialogContext!).maybePop();
//     // // if (_dialogContext!.canPop())
//     // // _dialogContext!.pop();
//     // // context.pop();
//     // _dialogContext = null;
//     // _dialogShown = false;
//   }
// }