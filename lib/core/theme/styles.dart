import 'package:flutter/material.dart';

abstract class Styles {
  // eg, headline text style:

  /// Values

  static const smallScreenWidthThreshold = 600;
  static const largeScreenWidthThreshold = 1200;

  static const paddingExtraSmall = 4.0;
  static const paddingSmall = 8.0;
  static const padding12 = 12.0;
  static const paddingMedium = 16.0;

  static const borderRadius = 12.0;

  static const spacingExtraSmall = 4.0;
  static const spacingSmall = 8.0;
  static const spacingMedium = 12.0;

  static const chipHeight = 32.0;
  static const buttonHeight = 48.0;

  static var interestIconSize = 64.0;

  static const fontSizeChip = 14.0;
  static const fontWeightChip = FontWeight.w500;
  static const fontSizeInterestDetailsTitle = 22.0;
  static const fontSizeInterestDetailsSectionTitle = 18.0;
  static const fontSizeInterestDetailsUser = 16.0;
  static const fontSizeInterestDetailsDescription = 16.0;
  static const fontSizeChatTitle = 16.0;
  static const fontSizeChatSubtitle = 14.0;
  static const fontSizeButton = 16.0;
  static const fontSizeChatAvatar = 10.0;
  static const fontSizeMessageName = 13.0;
  static const fontSizeMessageContent = 16.0;
  static const fontSizeSupportEmail = 16.0;
  static const fontSizeDeveloper = 20.0;

  static var menuElevation = 8.0;

  static const radiusChatAvatar = 8.0;
  static const radiusMessageAvatar = 4.0;

  /// Colors

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

  static const hintColor = Colors.blueGrey;

  static const chatSubtitleColor = Color(0xFF577D8F);

  /// Styles

  static const interestDetailsTitleTextStyle = TextStyle(
    color: primaryTextBlackColor,
    fontSize: fontSizeInterestDetailsTitle,
    fontWeight: FontWeight.bold,
  );

  static const interestDetailsSectionTitleTextStyle = TextStyle(
    color: primaryTextBlackColor,
    fontSize: fontSizeInterestDetailsSectionTitle,
    fontWeight: FontWeight.bold,
  );

  static const interestDetailsUserTextStyle = TextStyle(
    fontSize: fontSizeInterestDetailsUser,
    color: secondaryTextBlueColor,
  );

  static const supportEmailTextStyle = TextStyle(
    fontSize: fontSizeSupportEmail,
    color: primaryTextBlackColor,
  );

  static const developerTextStyle = TextStyle(
    fontSize: fontSizeDeveloper,
    color: secondaryTextBlueColor,
    fontFamily: fontFamilyDancingScript,
    fontVariations: [FontVariation(fontVariationAxisTagWeight, 700)],
  );

  static const interestDetailsDescriptionTextStyle = TextStyle(
    fontSize: fontSizeInterestDetailsDescription,
  );

  static const chatTitleTextStyle = TextStyle(
    fontSize: fontSizeChatTitle,
    fontWeight: FontWeight.w500,
  );

  static const chatSubtitleTextStyle = TextStyle(
    fontSize: fontSizeChatSubtitle,
    color: chatSubtitleColor,
    overflow: TextOverflow.fade,
  );

  // static const chatTimestampTextStyle = TextStyle(
  //   fontSize: fontSizeChatSubtitle,
  //   color: secondaryTextBlueColor,
  // );

  static const interestChipTextStyle = TextStyle(fontSize: fontSizeChip);

  static FilledButtonThemeData rsFilledButtonStyle = FilledButtonThemeData(
    style: ButtonStyle(
      minimumSize: WidgetStateProperty.all(
        const Size(double.infinity, buttonHeight),
      ),
      backgroundColor: WidgetStateProperty.all(buttonFullBackgroundColor),
      shape: WidgetStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
      ),
    ),
  );

  static const rsFilledButtonTextStyle = TextStyle(
    color: primaryTextBlackColor,
    fontSize: fontSizeButton,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle hintTextStyle = TextStyle(
    fontSize: Styles.fontSizeChip,
    color: hintColor,
  );

  static InputDecoration rsInputDecoration({
    required String? label,
    required String? hint,
  }) {
    return InputDecoration(
      labelText: label,
      labelStyle: Styles.interestDetailsSectionTitleTextStyle,
      border: InputBorder.none,
      hintText: hint,
      hintStyle: hintTextStyle,
    );
  }

  static const TextStyle messageNameTextStyle = TextStyle(
    fontSize: Styles.fontSizeMessageName,
    color: secondaryTextBlueColor,
  );

  static const TextStyle messageContentTextStyle = TextStyle(
    fontSize: Styles.fontSizeMessageContent,
    color: primaryTextBlackColor,
  );

  /// Font Families

  static const fontFamilyPlusJakartaSans = 'PlusJakartaSans';
  static const fontFamilyDancingScript = 'DancingScript';

  /// Font Axis Tag Names

  static const fontVariationAxisTagItalic = 'ital';
  static const fontVariationAxisTagOpticalSize = 'opsz';
  static const fontVariationAxisTagSlant = 'slnt';
  static const fontVariationAxisTagWidth = 'wdth';
  static const fontVariationAxisTagWeight = 'wght';
}
