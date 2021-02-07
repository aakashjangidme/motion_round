import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  static const defaultPadding =
      EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0);

  static const String fontFamily = 'Gilroy';

  static const kBlack = Color(0xff000000);
  static final kLightBlack = Color(0xff000000).withOpacity(0.5);
  static const kAccent = Color(0xffF4325C);
  static const kSecondary = Color(0xffFB8C66);

  static final _kHeading4 = TextStyle(
    fontSize: 24,
    color: kBlack,
    fontWeight: FontWeight.w800,
  );
  static final _kBody1 = TextStyle(
    fontSize: 16,
    color: kBlack,
    fontWeight: FontWeight.w600,
  );

  static final _kBody2 = TextStyle(
    fontSize: 14,
    color: kBlack,
    fontWeight: FontWeight.w400,
  );

  static final _kCaption = TextStyle(
    fontSize: 14,
    color: kLightBlack,
    fontWeight: FontWeight.w400,
  );

  static TextTheme textThemeLight = TextTheme(
    caption: _kCaption,
    headline4: _kHeading4,
    bodyText1: _kBody1,
    bodyText2: _kBody2,
    button: _kBody1.copyWith(fontSize: 14),
  );

  static OutlineInputBorder inputBorderLight = OutlineInputBorder(
    borderSide: BorderSide(
      color: Colors.black.withOpacity(0.12),
    ),
  );

  static OutlineInputBorder focusBorder = OutlineInputBorder(
    borderSide: BorderSide(
      color: kSecondary.withOpacity(0.5),
    ),
  );
  static OutlineInputBorder errInputBorder = OutlineInputBorder(
    borderSide: BorderSide(
      color: Colors.red.withOpacity(0.7),
    ),
  );

  static ThemeData lightTheme = ThemeData(
    primaryColor: AppTheme.kAccent,
    accentColor: AppTheme.kSecondary,
    colorScheme: ColorScheme.light(
      primary: AppTheme.kAccent,
      onPrimary: AppTheme.kWhite,
    ),
    fontFamily: fontFamily,
    textTheme: textThemeLight,
    cursorColor: kAccent,
    iconTheme: IconThemeData(color: kScaffoldDark),
    buttonTheme: ButtonThemeData(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      splashColor: kSecondary.withOpacity(0.24),
      highlightColor: kAccent.withOpacity(0.1),
    ),
    inputDecorationTheme: InputDecorationTheme(
      focusedErrorBorder: errInputBorder,
      errorBorder: errInputBorder,
      enabledBorder: inputBorderLight,
      focusedBorder: focusBorder,
      errorMaxLines: 2,
      labelStyle: TextStyle(
        color: Colors.black.withOpacity(0.5),
        fontWeight: FontWeight.w500,
        fontSize: 14,
      ),
      hintStyle: TextStyle(
        color: Colors.black.withOpacity(0.5),
        fontWeight: FontWeight.w500,
        fontSize: 14,
      ),
    ),
  );

  static const Color kScaffoldDark = Color(0xff272727);
  static const kAccentDark = Color(0xff383838);

  static final kWhite = Color(0xffFAFAFA).withOpacity(0.9);
  static final kWhiteLight = Color(0xffFAFAFA).withOpacity(0.5);
  static OutlineInputBorder inputBorderDark = OutlineInputBorder(
    borderSide: BorderSide(
      color: Colors.white.withOpacity(0.12),
    ),
  );

  static TextTheme textThemeDark = TextTheme(
    caption: _kCaption.copyWith(
      color: kWhiteLight,
    ),
    headline4: _kHeading4.copyWith(
      color: kWhite,
    ),
    bodyText1: _kBody1.copyWith(
      color: kWhite,
    ),
    bodyText2: _kBody2.copyWith(
      color: kWhite,
    ),
    button: _kBody1.copyWith(
      fontSize: 14,
      color: kWhite,
    ),
  );

  static ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: kScaffoldDark,
    canvasColor: kAccentDark,
    cardColor: kAccentDark,
    primaryColor: AppTheme.kSecondary.withOpacity(0.8),
    accentColor: AppTheme.kSecondary,
    disabledColor: kWhiteLight.withOpacity(0.5),
    colorScheme: ColorScheme.dark(
      primary: AppTheme.kSecondary.withOpacity(0.8),
    ),
    fontFamily: fontFamily,
    textTheme: textThemeDark,
    cursorColor: kAccent,
    iconTheme: IconThemeData(color: kWhite),
    buttonTheme: ButtonThemeData(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      splashColor: kSecondary.withOpacity(0.6),
      highlightColor: kAccent.withOpacity(0.1),
    ),
    dialogTheme: DialogTheme(
      backgroundColor: kAccentDark,
    ),
    inputDecorationTheme: InputDecorationTheme(
      focusedErrorBorder: errInputBorder,
      errorBorder: errInputBorder,
      enabledBorder: inputBorderDark,
      focusedBorder: focusBorder,
      errorMaxLines: 2,
      labelStyle: TextStyle(
        color: Colors.white.withOpacity(0.5),
        fontWeight: FontWeight.w500,
        fontSize: 14,
      ),
      hintStyle: TextStyle(
        color: Colors.white.withOpacity(0.5),
        fontWeight: FontWeight.w500,
        fontSize: 14,
      ),
    ),
  );
}
