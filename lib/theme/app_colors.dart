import 'package:flutter/material.dart';

final class AppColors extends ThemeExtension<AppColors> {
  final Color? defaultColor;
  final Color? secondary;
  final Color? background;
  final Color? appButtonPrimaryBackground;
  final Color? appButtonDisabled;
  final Color? appTextFieldFill;
  final Color? labelGrey;
  final Color? greyText;
  final Color? primaryLink;
  final Color? black;
  final Color? errorRed;
  final Color? successGreen;

  const AppColors({
    required this.defaultColor,
    required this.secondary,
    required this.background,
    required this.appButtonPrimaryBackground,
    required this.appButtonDisabled,
    required this.appTextFieldFill,
    required this.labelGrey,
    required this.greyText,
    required this.primaryLink,
    required this.black,
    required this.errorRed,
    required this.successGreen,
  });

  @override
  AppColors copyWith({
    Color? defaultColor,
    Color? secondary,
    Color? background,
    Color? appButtonPrimaryBackground,
    Color? appButtonDisabled,
    Color? appTextFieldFill,
    Color? labelGrey,
    Color? greyText,
    Color? primaryLink,
    Color? black,
    Color? errorRed,
    Color? successGreen,
  }) => AppColors(
    defaultColor: defaultColor ?? this.defaultColor,
    secondary: secondary ?? this.secondary,
    background: background ?? this.background,
    appButtonPrimaryBackground:
        appButtonPrimaryBackground ?? this.appButtonPrimaryBackground,
    appButtonDisabled: appButtonDisabled ?? this.appButtonDisabled,
    appTextFieldFill: appTextFieldFill ?? this.appTextFieldFill,
    labelGrey: labelGrey ?? this.labelGrey,
    greyText: greyText ?? this.greyText,
    primaryLink: primaryLink ?? this.primaryLink,
    black: black ?? this.black,
    errorRed: errorRed ?? this.errorRed,
    successGreen: successGreen ?? this.successGreen,
  );

  @override
  AppColors lerp(AppColors? other, double t) {
    if (other is! AppColors) return this;
    return AppColors(
      defaultColor: Color.lerp(defaultColor, other.defaultColor, t),
      secondary: Color.lerp(secondary, other.secondary, t),
      background: Color.lerp(background, other.background, t),
      appButtonPrimaryBackground: Color.lerp(
        appButtonPrimaryBackground,
        other.appButtonPrimaryBackground,
        t,
      ),
      appButtonDisabled: Color.lerp(
        appButtonDisabled,
        other.appButtonDisabled,
        t,
      ),
      appTextFieldFill: Color.lerp(appTextFieldFill, other.appTextFieldFill, t),
      labelGrey: Color.lerp(labelGrey, other.labelGrey, t),
      greyText: Color.lerp(greyText, other.greyText, t),
      primaryLink: Color.lerp(primaryLink, other.primaryLink, t),
      black: Color.lerp(black, other.black, t),
      errorRed: Color.lerp(errorRed, other.errorRed, t),
      successGreen: Color.lerp(successGreen, other.successGreen, t),
    );
  }
}
