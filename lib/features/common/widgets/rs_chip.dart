import 'package:flutter/material.dart';

import '../../../core/theme/styles.dart';

class RsChip extends StatelessWidget {
  final List<Widget> children;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final Color chipColor;
  final double paddingLeft;
  final double paddingRight;
  final double paddingTop;
  final double paddingBottom;

  const RsChip({
    super.key,
    required this.children,
    this.onTap,
    this.onLongPress,
    this.chipColor = Styles.skillChipBackgroundColor,
    this.paddingLeft = Styles.paddingMedium,
    this.paddingRight = Styles.paddingMedium,
    this.paddingTop = Styles.paddingExtraSmall,
    this.paddingBottom = Styles.paddingExtraSmall,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      onLongPress: onLongPress,
      borderRadius: BorderRadius.circular(Styles.borderRadius),
      child: Ink(
        height: Styles.chipHeight,
        padding: EdgeInsets.only(
          left: paddingLeft,
          right: paddingRight,
          top: paddingTop,
          bottom: paddingBottom,
        ),
        decoration: BoxDecoration(
          color: chipColor,
          borderRadius: BorderRadius.circular(Styles.borderRadius),
        ),
        child: Row(
          spacing: Styles.spacingSmall,
          mainAxisSize: MainAxisSize.min,
          children: children,
        ),
      ),
    );
  }
}
