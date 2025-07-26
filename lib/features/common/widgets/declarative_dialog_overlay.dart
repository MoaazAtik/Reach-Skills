import 'package:flutter/material.dart';

import '../../../core/theme/styles.dart';

class DeclarativeDialogOverlay extends StatelessWidget {
  final Widget child;
  final VoidCallback onDismiss;

  const DeclarativeDialogOverlay({
    super.key,
    required this.child,
    required this.onDismiss,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Barrier
        Positioned.fill(
          child: GestureDetector(
            onTap: onDismiss,
            child: Container(
              color: Colors.black54,
            ),
          ),
        ),

        Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Styles.borderRadius),
          ),
          backgroundColor: Styles.rsDefaultSurfaceColor,
          child: child,
        ),

        // Or manually create a Dialog
        // Center(
        //   child: Material(
        //     elevation: 24,
        //     // color: Theme.of(context).dialogBackgroundColor,
        //     color: Theme.of(context).dialogTheme.backgroundColor,
        //     shape: RoundedRectangleBorder(
        //       borderRadius: BorderRadius.circular(16),
        //     ),
        //     child: ConstrainedBox(
        //       // constraints: BoxConstraints(maxWidth: 500),
        //       constraints: BoxConstraints(maxWidth: MediaQuery.sizeOf(context).width * 0.8),
        //       child: child,
        //       // child: IntrinsicHeight(
        //       //   child: child,
        //       // ),
        //     ),
        //   ),
        // ),
      ],
    );
  }
}
