import 'package:flutter/material.dart';
import 'package:shopzy/theme/app_colors.dart';
import 'package:shopzy/theme/app_text_styles.dart';

//light mode
final primaryTheme = _getTheme(
  appColors: AppColors(
    defaultColor: Colors.white,
    secondary: Color(0xFF000000),
    background: Color.fromARGB(255, 240, 239, 239),
    appButtonPrimaryBackground: Color(0xff3669C9),
    appButtonDisabled: const Color(0xffC4C5C4),
    appTextFieldFill: Color(0xffFAFAFA),
    labelGrey: Color(0xff838589),
    greyText: Color(0xff838589),
    primaryLink: Color(0xff3669C9),
    black: Colors.black,
    errorRed: Colors.redAccent,
    successGreen: Colors.greenAccent,
    scrollbarColor: Colors.black.withValues(alpha: 0.7),
    gold: Color(0xffDAA520),
  ),
);

//dark mode
final secondaryTheme = _getTheme(
  appColors: AppColors(
    defaultColor: Colors.white,
    secondary: Color(0xFFFFFFFF),
    background: Color(0xFF121212),
    appButtonPrimaryBackground: Color(0xff3669C9),
    appButtonDisabled: const Color(0xffC4C5C4),
    appTextFieldFill: Color(0xFF1D1D1D),
    labelGrey: Color(0xff838589),
    greyText: Color(0xff838589),
    primaryLink: Color(0xff3669C9),
    black: Colors.black,
    errorRed: Colors.redAccent,
    successGreen: Colors.greenAccent,
    scrollbarColor: Colors.white.withValues(alpha: 0.7),
    gold: Color(0xffDAA520),
  ),
);

ThemeData _getTheme({required AppColors appColors}) {
  return ThemeData(
    primarySwatch: Colors.cyan,
    colorScheme: ThemeData().colorScheme.copyWith(
      primary: appColors.defaultColor,
      secondary: appColors.secondary,
    ),
    scaffoldBackgroundColor: appColors.background,
    scrollbarTheme: ScrollbarThemeData(
      thumbColor: WidgetStateProperty.all(appColors.scrollbarColor),
      trackColor: WidgetStateProperty.all(Colors.transparent),
      thickness: WidgetStateProperty.all(3),
      radius: const Radius.circular(40),
    ),
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: appColors.secondary,
      selectionColor: appColors.secondary?.withAlpha(51),
      selectionHandleColor: appColors.secondary,
    ),
    extensions: [
      appColors,
      getAppTextStyles(
        defaultColor: appColors.defaultColor!,
        secondaryColor: appColors.secondary!,
        appColors: appColors,
      ),
    ],
  );
}
