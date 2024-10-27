import "package:flutter/material.dart";

class MaterialTheme {
  final TextTheme textTheme;

  const MaterialTheme(this.textTheme);

  static ColorScheme lightHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff002728),
      surfaceTint: Color(0xff00696c),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff004b4d),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff002729),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff004b4e),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff002823),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff004c45),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff4e0002),
      onError: Color(0xffffffff),
      errorContainer: Color(0xff8c0009),
      onErrorContainer: Color(0xffffffff),
      surface: Color(0xfff4fbfa),
      onSurface: Color(0xff000000),
      onSurfaceVariant: Color(0xff1c2626),
      outline: Color(0xff3b4545),
      outlineVariant: Color(0xff3b4545),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff2b3232),
      inversePrimary: Color(0xffa6fafd),
      primaryFixed: Color(0xff004b4d),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff003334),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xff004b4e),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff003335),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xff004c45),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff00332e),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffd5dbdb),
      surfaceBright: Color(0xfff4fbfa),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xffeff5f5),
      surfaceContainer: Color(0xffe9efef),
      surfaceContainerHigh: Color(0xffe3e9e9),
      surfaceContainerHighest: Color(0xffdde4e4),
    );
  }

  ThemeData lightHighContrast() {
    return theme(lightHighContrastScheme());
  }

  static ColorScheme darkScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xff80d4d7),
      surfaceTint: Color(0xff80d4d7),
      onPrimary: Color(0xff003738),
      primaryContainer: Color(0xff004f51),
      onPrimaryContainer: Color(0xff9cf1f3),
      secondary: Color(0xff80d4d9),
      onSecondary: Color(0xff003739),
      secondaryContainer: Color(0xff004f53),
      onSecondaryContainer: Color(0xff9cf0f5),
      tertiary: Color(0xff82d5c9),
      onTertiary: Color(0xff003732),
      tertiaryContainer: Color(0xff005049),
      onTertiaryContainer: Color(0xff9ef2e5),
      error: Color(0xffffb4ab),
      onError: Color(0xff690005),
      errorContainer: Color(0xff93000a),
      onErrorContainer: Color(0xffffdad6),
      surface: Color(0xff0e1415),
      onSurface: Color(0xffdde4e4),
      onSurfaceVariant: Color(0xffbec8c9),
      outline: Color(0xff899393),
      outlineVariant: Color(0xff3f4949),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffdde4e4),
      inversePrimary: Color(0xff00696c),
      primaryFixed: Color(0xff9cf1f3),
      onPrimaryFixed: Color(0xff002021),
      primaryFixedDim: Color(0xff80d4d7),
      onPrimaryFixedVariant: Color(0xff004f51),
      secondaryFixed: Color(0xff9cf0f5),
      onSecondaryFixed: Color(0xff002021),
      secondaryFixedDim: Color(0xff80d4d9),
      onSecondaryFixedVariant: Color(0xff004f53),
      tertiaryFixed: Color(0xff9ef2e5),
      onTertiaryFixed: Color(0xff00201c),
      tertiaryFixedDim: Color(0xff82d5c9),
      onTertiaryFixedVariant: Color(0xff005049),
      surfaceDim: Color(0xff0e1415),
      surfaceBright: Color(0xff343a3b),
      surfaceContainerLowest: Color(0xff090f10),
      surfaceContainerLow: Color(0xff161d1d),
      surfaceContainer: Color(0xff1a2121),
      surfaceContainerHigh: Color(0xff252b2b),
      surfaceContainerHighest: Color(0xff303636),
    );
  }

  ThemeData dark() {
    return theme(darkScheme());
  }

  ThemeData theme(ColorScheme colorScheme) => ThemeData(
        useMaterial3: true,
        brightness: colorScheme.brightness,
        colorScheme: colorScheme,
        textTheme: textTheme.apply(
          bodyColor: colorScheme.onSurface,
          displayColor: colorScheme.onSurface,
        ),
        scaffoldBackgroundColor: colorScheme.surface,
        canvasColor: colorScheme.surface,
      );

  List<ExtendedColor> get extendedColors => [];
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
