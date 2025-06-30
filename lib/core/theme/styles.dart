import 'package:flutter/cupertino.dart';

abstract class Styles {
  // headline text style:

  // skill background color

  // interest background color

  static const skillChipBackgroundColor = Color(0xFFE8F0F2);
  static const wishChipBackgroundColor = Color(0xFFF6E7DF);

  static const wishCardGradientStartColor = Color(0xFFF6E7DF);
  static const wishCardGradientEndColor = Color(0xFFE9D0BF);

  static const skillCardGradientStartColor = Color(0xFFD7E8EC);
  static const skillCardGradientEndColor = Color(0xFF96C6C5);

  static const wishCardBackgroundColor = LinearGradient(
    colors: [wishCardGradientStartColor, wishCardGradientEndColor],
  );
  static const skillCardBackgroundColor = LinearGradient(
    colors: [skillCardGradientStartColor, skillCardGradientEndColor],
  );
}
