import 'package:flutter/material.dart';

import '../../../core/constants/values.dart';
import '../../../core/theme/styles.dart';

class RsChip extends StatelessWidget {
  final List<Widget> children;
  final VoidCallback? onTap;
  final Color chipColor;
  final double paddingLeft;
  final double paddingRight;
  final double paddingTop;
  final double paddingBottom;

  const RsChip({
    super.key,
    required this.children,
    this.onTap,
    this.chipColor = Styles.skillChipBackgroundColor,
    this.paddingLeft = Values.paddingMedium,
    this.paddingRight = Values.paddingMedium,
    this.paddingTop = Values.paddingExtraSmall,
    this.paddingBottom = Values.paddingExtraSmall,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(Values.borderRadius),
      child: Ink(
        height: Values.chipHeight,
        padding: EdgeInsets.only(
          left: paddingLeft,
          right: paddingRight,
          top: paddingTop,
          bottom: paddingBottom,
        ),
        decoration: BoxDecoration(
          color: chipColor,
          borderRadius: BorderRadius.circular(Values.borderRadius),
        ),
        child: Row(spacing: Values.spacingSmall, children: children),
      ),
    );
  }
}
