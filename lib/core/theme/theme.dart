import "package:flutter/material.dart";
import "package:reach_skills/core/theme/styles.dart";

class MaterialTheme {
  final TextTheme textTheme;

  const MaterialTheme(this.textTheme);

  static ColorScheme lightScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff00658b),
      surfaceTint: Color(0xff00658b),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff47b5eb),
      onPrimaryContainer: Color(0xff00445e),
      secondary: Color(0xff376665),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff96c6c5),
      onSecondaryContainer: Color(0xff235353),
      tertiary: Color(0xff675c56),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xfff6e7df),
      onTertiaryContainer: Color(0xff726761),
      error: Color(0xffba1a1a),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffffdad6),
      onErrorContainer: Color(0xff93000a),
      // surface: Color(0xfffcf8f8), // yellowish from Material builder
      surface: Color(0xfff7fafc), // bluish from Stitch
      onSurface: Color(0xff1c1b1b),
      onSurfaceVariant: Color(0xff434749),
      outline: Color(0xff737879),
      outlineVariant: Color(0xffc3c7c8),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff313030),
      inversePrimary: Color(0xff7dd0ff),
      primaryFixed: Color(0xffc4e7ff),
      onPrimaryFixed: Color(0xff001e2d),
      primaryFixedDim: Color(0xff7dd0ff),
      onPrimaryFixedVariant: Color(0xff004c6a),
      secondaryFixed: Color(0xffbbeceb),
      onSecondaryFixed: Color(0xff002020),
      secondaryFixedDim: Color(0xff9fcfce),
      onSecondaryFixedVariant: Color(0xff1d4e4e),
      tertiaryFixed: Color(0xffeee0d8),
      onTertiaryFixed: Color(0xff211a15),
      tertiaryFixedDim: Color(0xffd2c4bc),
      onTertiaryFixedVariant: Color(0xff4e453f),
      surfaceDim: Color(0xffdcd9d9),
      surfaceBright: Color(0xfffcf8f8),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfff6f3f2),
      surfaceContainer: Color(0xfff0eded),
      surfaceContainerHigh: Color(0xffebe7e7),
      surfaceContainerHighest: Color(0xffe5e2e1),
    );
  }

  ThemeData light() {
    return theme(lightScheme());
  }

  static ColorScheme lightMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff003b52),
      surfaceTint: Color(0xff00658b),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff0075a0),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff053d3d),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff467574),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff3d342f),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff766b65),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff740006),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffcf2c27),
      onErrorContainer: Color(0xffffffff),
      surface: Color(0xfffcf8f8),
      onSurface: Color(0xff111111),
      onSurfaceVariant: Color(0xff323738),
      outline: Color(0xff4f5354),
      outlineVariant: Color(0xff696e6f),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff313030),
      inversePrimary: Color(0xff7dd0ff),
      primaryFixed: Color(0xff0075a0),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff005b7d),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xff467574),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff2d5c5c),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xff766b65),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff5d534d),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffc9c6c5),
      surfaceBright: Color(0xfffcf8f8),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfff6f3f2),
      surfaceContainer: Color(0xffebe7e7),
      surfaceContainerHigh: Color(0xffdfdcdc),
      surfaceContainerHighest: Color(0xffd4d1d0),
    );
  }

  ThemeData lightMediumContrast() {
    return theme(lightMediumContrastScheme());
  }

  static ColorScheme lightHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff003044),
      surfaceTint: Color(0xff00658b),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff004f6d),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff003232),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff205050),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff332a25),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff514742),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff600004),
      onError: Color(0xffffffff),
      errorContainer: Color(0xff98000a),
      onErrorContainer: Color(0xffffffff),
      surface: Color(0xfffcf8f8),
      onSurface: Color(0xff000000),
      onSurfaceVariant: Color(0xff000000),
      outline: Color(0xff282d2e),
      outlineVariant: Color(0xff454a4b),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff313030),
      inversePrimary: Color(0xff7dd0ff),
      primaryFixed: Color(0xff004f6d),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff00374d),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xff205050),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff003939),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xff514742),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff39312c),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffbbb8b8),
      surfaceBright: Color(0xfffcf8f8),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfff3f0ef),
      surfaceContainer: Color(0xffe5e2e1),
      surfaceContainerHigh: Color(0xffd7d4d3),
      surfaceContainerHighest: Color(0xffc9c6c5),
    );
  }

  ThemeData lightHighContrast() {
    return theme(lightHighContrastScheme());
  }

  static ColorScheme darkScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xff7dd0ff),
      surfaceTint: Color(0xff7dd0ff),
      onPrimary: Color(0xff00344a),
      primaryContainer: Color(0xff47b5eb),
      onPrimaryContainer: Color(0xff00445e),
      secondary: Color(0xffb1e2e1),
      onSecondary: Color(0xff003737),
      secondaryContainer: Color(0xff96c6c5),
      onSecondaryContainer: Color(0xff235353),
      tertiary: Color(0xffffffff),
      onTertiary: Color(0xff372f2a),
      tertiaryContainer: Color(0xffeee0d8),
      onTertiaryContainer: Color(0xff6d625c),
      error: Color(0xffffb4ab),
      onError: Color(0xff690005),
      errorContainer: Color(0xff93000a),
      onErrorContainer: Color(0xffffdad6),
      surface: Color(0xff131313),
      onSurface: Color(0xffe5e2e1),
      onSurfaceVariant: Color(0xffc3c7c8),
      outline: Color(0xff8d9192),
      outlineVariant: Color(0xff434749),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffe5e2e1),
      inversePrimary: Color(0xff00658b),
      primaryFixed: Color(0xffc4e7ff),
      onPrimaryFixed: Color(0xff001e2d),
      primaryFixedDim: Color(0xff7dd0ff),
      onPrimaryFixedVariant: Color(0xff004c6a),
      secondaryFixed: Color(0xffbbeceb),
      onSecondaryFixed: Color(0xff002020),
      secondaryFixedDim: Color(0xff9fcfce),
      onSecondaryFixedVariant: Color(0xff1d4e4e),
      tertiaryFixed: Color(0xffeee0d8),
      onTertiaryFixed: Color(0xff211a15),
      tertiaryFixedDim: Color(0xffd2c4bc),
      onTertiaryFixedVariant: Color(0xff4e453f),
      surfaceDim: Color(0xff131313),
      surfaceBright: Color(0xff3a3939),
      surfaceContainerLowest: Color(0xff0e0e0e),
      surfaceContainerLow: Color(0xff1c1b1b),
      surfaceContainer: Color(0xff201f1f),
      surfaceContainerHigh: Color(0xff2a2a2a),
      surfaceContainerHighest: Color(0xff353535),
    );
  }

  ThemeData dark() {
    return theme(darkScheme());
  }

  static ColorScheme darkMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xffb6e2ff),
      surfaceTint: Color(0xff7dd0ff),
      onPrimary: Color(0xff00293b),
      primaryContainer: Color(0xff47b5eb),
      onPrimaryContainer: Color(0xff002333),
      secondary: Color(0xffb5e5e4),
      onSecondary: Color(0xff002b2b),
      secondaryContainer: Color(0xff96c6c5),
      onSecondaryContainer: Color(0xff003636),
      tertiary: Color(0xffffffff),
      onTertiary: Color(0xff372f2a),
      tertiaryContainer: Color(0xffeee0d8),
      onTertiaryContainer: Color(0xff4f4640),
      error: Color(0xffffd2cc),
      onError: Color(0xff540003),
      errorContainer: Color(0xffff5449),
      onErrorContainer: Color(0xff000000),
      surface: Color(0xff131313),
      onSurface: Color(0xffffffff),
      onSurfaceVariant: Color(0xffd9ddde),
      outline: Color(0xffaeb3b4),
      outlineVariant: Color(0xff8d9192),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffe5e2e1),
      inversePrimary: Color(0xff004e6b),
      primaryFixed: Color(0xffc4e7ff),
      onPrimaryFixed: Color(0xff00131e),
      primaryFixedDim: Color(0xff7dd0ff),
      onPrimaryFixedVariant: Color(0xff003b52),
      secondaryFixed: Color(0xffbbeceb),
      onSecondaryFixed: Color(0xff001414),
      secondaryFixedDim: Color(0xff9fcfce),
      onSecondaryFixedVariant: Color(0xff053d3d),
      tertiaryFixed: Color(0xffeee0d8),
      onTertiaryFixed: Color(0xff16100b),
      tertiaryFixedDim: Color(0xffd2c4bc),
      onTertiaryFixedVariant: Color(0xff3d342f),
      surfaceDim: Color(0xff131313),
      surfaceBright: Color(0xff454444),
      surfaceContainerLowest: Color(0xff070707),
      surfaceContainerLow: Color(0xff1e1d1d),
      surfaceContainer: Color(0xff282828),
      surfaceContainerHigh: Color(0xff333232),
      surfaceContainerHighest: Color(0xff3e3d3d),
    );
  }

  ThemeData darkMediumContrast() {
    return theme(darkMediumContrastScheme());
  }

  static ColorScheme darkHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xffe2f2ff),
      surfaceTint: Color(0xff7dd0ff),
      onPrimary: Color(0xff000000),
      primaryContainer: Color(0xff71cdff),
      onPrimaryContainer: Color(0xff000d16),
      secondary: Color(0xffc8f9f8),
      onSecondary: Color(0xff000000),
      secondaryContainer: Color(0xff9bcbca),
      onSecondaryContainer: Color(0xff000e0e),
      tertiary: Color(0xffffffff),
      onTertiary: Color(0xff000000),
      tertiaryContainer: Color(0xffeee0d8),
      onTertiaryContainer: Color(0xff302823),
      error: Color(0xffffece9),
      onError: Color(0xff000000),
      errorContainer: Color(0xffffaea4),
      onErrorContainer: Color(0xff220001),
      surface: Color(0xff131313),
      onSurface: Color(0xffffffff),
      onSurfaceVariant: Color(0xffffffff),
      outline: Color(0xffedf1f2),
      outlineVariant: Color(0xffbfc3c4),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffe5e2e1),
      inversePrimary: Color(0xff004e6b),
      primaryFixed: Color(0xffc4e7ff),
      onPrimaryFixed: Color(0xff000000),
      primaryFixedDim: Color(0xff7dd0ff),
      onPrimaryFixedVariant: Color(0xff00131e),
      secondaryFixed: Color(0xffbbeceb),
      onSecondaryFixed: Color(0xff000000),
      secondaryFixedDim: Color(0xff9fcfce),
      onSecondaryFixedVariant: Color(0xff001414),
      tertiaryFixed: Color(0xffeee0d8),
      onTertiaryFixed: Color(0xff000000),
      tertiaryFixedDim: Color(0xffd2c4bc),
      onTertiaryFixedVariant: Color(0xff16100b),
      surfaceDim: Color(0xff131313),
      surfaceBright: Color(0xff515050),
      surfaceContainerLowest: Color(0xff000000),
      surfaceContainerLow: Color(0xff201f1f),
      surfaceContainer: Color(0xff313030),
      surfaceContainerHigh: Color(0xff3c3b3b),
      surfaceContainerHighest: Color(0xff474646),
    );
  }

  ThemeData darkHighContrast() {
    return theme(darkHighContrastScheme());
  }


  ThemeData theme(ColorScheme colorScheme) => ThemeData(
    useMaterial3: true,
    brightness: colorScheme.brightness,
    colorScheme: colorScheme,
    textTheme: textTheme.apply(
      fontFamily: 'PlusJakartaSans',
      bodyColor: colorScheme.onSurface,
      displayColor: colorScheme.onSurface,
    ),
    scaffoldBackgroundColor: colorScheme.surface,
    canvasColor: colorScheme.surface,

    // Custom filled button theme
    filledButtonTheme: Styles.rsFilledButtonStyle
  );


  List<ExtendedColor> get extendedColors => [
  ];
}

class ExtendedColor {
  final Color seed, value;
  final ColorFamily light;
  final ColorFamily lightHighContrast;
  final ColorFamily lightMediumContrast;
  final ColorFamily dark;
  final ColorFamily darkHighContrast;
  final ColorFamily darkMediumContrast;

  const ExtendedColor({
    required this.seed,
    required this.value,
    required this.light,
    required this.lightHighContrast,
    required this.lightMediumContrast,
    required this.dark,
    required this.darkHighContrast,
    required this.darkMediumContrast,
  });
}

class ColorFamily {
  const ColorFamily({
    required this.color,
    required this.onColor,
    required this.colorContainer,
    required this.onColorContainer,
  });

  final Color color;
  final Color onColor;
  final Color colorContainer;
  final Color onColorContainer;
}
