import 'package:flutter/material.dart';

import '../constants/values.dart';

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

  static const primaryTextBlackColor = Color(0xFF0D171C);
  static const secondaryTextBlueColor = Color(0xFF4F8096);

  static const buttonFullBackgroundColor = Color(0xFF47B5EB);
  static const buttonPaleBackgroundColor = Color(0xFFADD6EB);

  static const wishCardBackgroundColor = LinearGradient(
    colors: [wishCardGradientStartColor, wishCardGradientEndColor],
  );
  static const skillCardBackgroundColor = LinearGradient(
    colors: [skillCardGradientStartColor, skillCardGradientEndColor],
  );

  static const rsDefaultSurfaceColor = Color(0xfff7fafc); // bluish from Stitch

  static const interestDetailsTitleTextStyle = TextStyle(
    fontSize: Values.fontSizeInterestDetailsTitle,
    fontWeight: FontWeight.bold,
  );

  static const interestDetailsSectionTitleTextStyle = TextStyle(
    fontSize: Values.fontSizeInterestDetailsSectionTitle,
    fontWeight: FontWeight.bold,
  );

  static const interestDetailsUserTextStyle = TextStyle(
    fontSize: Values.fontSizeInterestDetailsUser,
    color: secondaryTextBlueColor,
  );

  static const interestDetailsDescriptionTextStyle = TextStyle(
    fontSize: Values.fontSizeInterestDetailsDescription,
  );

  static const interestChipTextStyle = TextStyle(fontSize: Values.fontSizeChip);

  static FilledButtonThemeData rsFilledButtonStyle = FilledButtonThemeData(
    style: ButtonStyle(
      minimumSize: WidgetStateProperty.all(
        const Size(double.infinity, Values.buttonHeight),
      ),
      backgroundColor: WidgetStateProperty.all(buttonFullBackgroundColor),
      shape: WidgetStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Values.borderRadius),
        ),
      ),
    ),
  );

  static const rsFilledButtonTextStyle = TextStyle(
    color: primaryTextBlackColor,
    fontSize: Values.fontSizeButton,
    fontWeight: FontWeight.bold,
  );
}
