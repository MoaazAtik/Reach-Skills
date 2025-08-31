import 'package:flutter/material.dart';

import '../../features/common/data/interest_model.dart';

abstract class Styles {
  // eg, headline text style:

  /// Values

  static const smallScreenWidthThreshold = 600;
  static const largeScreenWidthThreshold = 1200;

  static const paddingExtraSmall = 4.0;
  static const paddingSmall = 8.0;
  static const padding12 = 12.0;
  static const paddingMedium = 16.0;
  static const padding20 = 20.0;

  static const borderRadius = 12.0;

  static const spacingExtraSmall = 4.0;
  static const spacingSmall = 8.0;
  static const spacing12 = 12.0;
  static const spacingMedium = 16.0;

  static const chipHeight = 32.0;
  static const buttonHeight = 48.0;
  static const buttonMinWidthM3 = 64.0; // Material 3 default
  static const buttonMinHeightM3 = 40.0; // Material 3 default
  static const progressChipHeight = 8.0;

  static const interestIconSize = 64.0;
  static const appLogoSize = 40.0;
  static const illustrationMaxWidth = 500.0;

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
  static const fontSizeOnboardingTitle = 28.0;
  static const fontSizeOnboardingDescription = 16.0;
  static const fontSize16 = 16.0;
  static const fontSize14 = 16.0;

  static const elevationCard = 4.0;
  static const elevationMenu = 8.0;
  static const elevationDialog = 24.0;

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
  static const progressUndoneBackgroundColor = Color(0xFFD4DEE3);

  static const wishCardBackgroundColor = LinearGradient(
    colors: [wishCardGradientStartColor, wishCardGradientEndColor],
  );
  static const skillCardBackgroundColor = LinearGradient(
    colors: [skillCardGradientStartColor, skillCardGradientEndColor],
  );

  /// bluish from Stitch. Used by `dialogBarrierColor` too.
  static const rsDefaultSurfaceColor = Color(0xfff7fafc);

  static const hintColor = Colors.blueGrey;
  static const chatSubtitleColor = Color(0xFF577D8F);

  static final dialogBackgroundColor = rsDefaultSurfaceColor;
  static final dialogBarrierColor = rsDefaultSurfaceColor.withAlpha(80);
  static final dialogShadowColor = Colors.black54;

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
    overflow: TextOverflow.ellipsis,
  );

  // Todo use or remove
  // static const chatTimestampTextStyle = TextStyle(
  //   fontSize: fontSizeChatSubtitle,
  //   color: secondaryTextBlueColor,
  // );

  static const interestChipTextStyle = TextStyle(fontSize: fontSizeChip);

  static FilledButtonThemeData rsFilledButtonStyle = FilledButtonThemeData(
    style: ButtonStyle(
      minimumSize: WidgetStateProperty.all(
        const Size(buttonMinWidthM3, buttonHeight),
      ),
      backgroundColor: WidgetStateProperty.all(buttonFullBackgroundColor),
      shape: WidgetStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
      ),
    ),
  );

  static OutlinedButtonThemeData rsOutlinedButtonStyle =
      OutlinedButtonThemeData(
        style: ButtonStyle(
          minimumSize: WidgetStateProperty.all(
            const Size(buttonMinWidthM3, buttonHeight),
          ),
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius),
            ),
          ),
        ),
      );

  static ElevatedButtonThemeData rsElevatedButtonStyle =
      ElevatedButtonThemeData(
        style: ButtonStyle(
          minimumSize: WidgetStateProperty.all(
            const Size(buttonMinWidthM3, buttonHeight),
          ),
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius),
            ),
          ),
        ),
      );

  /// Affected by the custom app style `rsOutlinedButtonStyle`
  static final styleSendButton = OutlinedButton.styleFrom(
    minimumSize: const Size(buttonMinWidthM3, buttonHeight),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(Styles.borderRadius),
    ),
    side: const BorderSide(style: BorderStyle.none),
    padding: const EdgeInsets.all(Styles.paddingMedium),
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
    String? label,
    String? hint,
    bool withConstrains = false,
    double? maxWidth,
    double maxWidthRatio = 0.5,
    BuildContext? context,
    Color? fillColor,
  }) {
    assert(
      !withConstrains || (maxWidth != null || context != null),
      'rsInputDecoration: If the widget is meant to be `withConstrains`,'
      ' `maxWidth` should be provided,'
      ' Or you could provide `context` for calculating maxWidth dynamically.',
    );

    return InputDecoration(
      labelText: label,
      labelStyle: Styles.interestDetailsSectionTitleTextStyle,
      floatingLabelBehavior: FloatingLabelBehavior.never,
      hintText: hint,
      hintStyle: hintTextStyle,
      isDense: true,
      // isCollapsed: true,
      constraints:
          !withConstrains
              ? null
              : BoxConstraints(
                maxWidth:
                    maxWidth ??
                    MediaQuery.sizeOf(context!).width * maxWidthRatio,
              ),
      filled: fillColor != null ? true : null,
      fillColor: fillColor,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(Styles.borderRadius),
        borderSide: BorderSide.none,
      ),
      // contentPadding: EdgeInsets.symmetric(vertical: Styles.paddingMedium, horizontal: Styles.paddingMedium),
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

  static const TextStyle onboardingTitleTextStyle = TextStyle(
    fontSize: Styles.fontSizeOnboardingTitle,
    color: primaryTextBlackColor,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle onboardingDescriptionTextStyle = TextStyle(
    fontSize: Styles.fontSizeOnboardingDescription,
    color: primaryTextBlackColor,
  );

  static const TextStyle textStyle16BlackWeightMedium = TextStyle(
    fontSize: fontSize16,
    color: primaryTextBlackColor,
    fontWeight: FontWeight.w500,
  );

  static const TextStyle textStyle14SubtitleBlue = TextStyle(
    fontSize: fontSize16,
    color: chatSubtitleColor,
  );

  static final shapeDialog = RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(Styles.borderRadius),
  );

  /// Helper Utils Methods

  static Color getChipColor(InterestType interestType) {
    return interestType == InterestType.wish
        ? Styles.wishChipBackgroundColor
        : Styles.skillChipBackgroundColor;
  }

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
