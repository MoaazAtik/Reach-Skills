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
              /* Color is implemented similarly to
               the `barrierColor` in the dialog.dart */
              color:
                  DialogTheme.of(context).barrierColor ??
                  Theme.of(context).dialogTheme.barrierColor ??
                  Styles.dialogBarrierColor,
            ),
          ),
        ),

        /* Dialog's barrierColor, backgroundColor, shadowColor, elevation, shape
        properties are implemented by theme.dart. */
        Dialog(child: child),
      ],
    );
  }
}
