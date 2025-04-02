import 'package:flutter/material.dart';

enum ThemeType {
  light,
  dark,
}

class AppTheme {
  static ThemeType defaultTheme = ThemeType.light;

  //Theme Colors
  bool isDark;
  Color txt;
  Color primary;

  Color secondary;

  Color darkText;
  Color white;
  Color sameWhite;
  Color sameBlack;
  Color borderColor;
  Color textField;
  Color greyText;
  Color redColor;
  Color yellowColor;
  Color online;
  Color tick;
  Color black;

  /// Default constructor
  AppTheme(
      {required this.isDark,
      required this.txt,
      required this.primary,
      required this.black,

      required this.secondary,
      required this.darkText,
      required this.white,
      required this.sameWhite,
      required this.sameBlack,
      required this.borderColor,
      required this.textField,
      required this.greyText,
      required this.redColor,
      required this.yellowColor,
      required this.online,
      required this.tick});

  /// fromType factory constructor
  factory AppTheme.fromType(ThemeType t) {
    switch (t) {
      case ThemeType.light:
        return AppTheme(
          isDark: false,
          txt: const Color(0xFF323444),
          primary: const Color(0xff367CF6),
          darkText: const Color(0xff2C2C2C),
          greyText: const Color(0xff7F8384),
          white: Colors.white,
          borderColor: const Color(0xffF2F3F3),
          online: const Color(0xff4DD68C),
          tick: const Color(0xff80D4C2),
          secondary: const Color(0xFF6EBAE7),
          sameWhite: Colors.white,
          sameBlack: Colors.black,
          black: Colors.black,
          textField: const Color(0xffF5F5F6),
          redColor: const Color(0XFFFE3D3D),
          yellowColor: const Color(0XFFFFC700),
        );

      case ThemeType.dark:
        return AppTheme(
          isDark: true,
          txt: Colors.white,
          primary: const Color(0xff367CF6),
          darkText: const Color(0xfff5f5f5),
          greyText: const Color(0xff7F8384),
          white: const Color(0xff333232),
          borderColor: const Color(0xff262424),
          online: const Color(0xff4DD68C),
          tick: const Color(0xff80D4C2),

          secondary: const Color(0xFF6EBAE7),

          sameWhite: Colors.white,
          sameBlack: Colors.black,
          black: Colors.white,
          textField: const Color(0xff4D4F5D),

          redColor: const Color(0XFFFE3D3D),
          yellowColor: const Color(0XFFFFC700),
        );
    }
  }

  ThemeData get themeData {
    var t = ThemeData.from(
      textTheme: (isDark ? ThemeData.dark() : ThemeData.light()).textTheme,
      colorScheme: ColorScheme(
          brightness: isDark ? Brightness.dark : Brightness.light,
          primary: primary,
          secondary: secondary,

          surface: white,
          onSurface: txt,
          onError: txt,
          onPrimary: primary,
          onSecondary: secondary,
          error: redColor,
          primaryContainer: white,
          surfaceTint: white),
    );

    return t.copyWith(
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      textSelectionTheme: TextSelectionThemeData(
          selectionHandleColor: Colors.transparent, cursorColor: primary),
      buttonTheme: ButtonThemeData(buttonColor: primary),
      highlightColor: primary,
    );
  }
}
