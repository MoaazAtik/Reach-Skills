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
      ],
    );
  }
}
