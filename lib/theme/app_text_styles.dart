import 'package:flutter/material.dart';
import 'package:shopzy/common/presentation/app_sizes.dart';
import 'package:shopzy/theme/app_colors.dart';

final class AppTextStyles extends ThemeExtension<AppTextStyles> {
  final TextStyle? regular;
  final TextStyle? bold;
  final TextStyle? boldLarge;
  final TextStyle? button;
  final TextStyle? title;
  final TextStyle? subtitle;
  final TextStyle? label;
  final TextStyle? divider;
  final TextStyle? link;
  final TextStyle? linkPrimary;

  // Private constructor to ensure all styles are properly initialized
  const AppTextStyles._({
    required this.regular,
    required this.bold,
    required this.boldLarge,
    required this.button,
    required this.title,
    required this.subtitle,
    required this.label,
    required this.divider,
    required this.link,
    required this.linkPrimary,
  });

  @override
  AppTextStyles copyWith({
    TextStyle? regular,
    TextStyle? bold,
    TextStyle? boldLarge,
    TextStyle? button,
    TextStyle? title,
    TextStyle? subtitle,
    TextStyle? label,
    TextStyle? divider,
    TextStyle? link,
    TextStyle? linkPrimary,
  }) => AppTextStyles._(
    regular: regular ?? this.regular,
    bold: bold ?? this.bold,
    boldLarge: boldLarge ?? this.boldLarge,
    button: button ?? this.button,
    title: title ?? this.title,
    subtitle: subtitle ?? this.subtitle,
    label: label ?? this.label,
    divider: divider ?? this.divider,
    link: link ?? this.link,
    linkPrimary: linkPrimary ?? this.linkPrimary,
  );

  @override
  AppTextStyles lerp(AppTextStyles? other, double t) {
    if (other is! AppTextStyles) return this;
    return AppTextStyles._(
      regular: TextStyle.lerp(regular, other.regular, t),
      bold: TextStyle.lerp(bold, other.bold, t),
      boldLarge: TextStyle.lerp(boldLarge, other.boldLarge, t),
      button: TextStyle.lerp(button, other.button, t),
      title: TextStyle.lerp(title, other.title, t),
      subtitle: TextStyle.lerp(subtitle, other.subtitle, t),
      label: TextStyle.lerp(label, other.label, t),
      divider: TextStyle.lerp(divider, other.divider, t),
      link: TextStyle.lerp(link, other.link, t),
      linkPrimary: TextStyle.lerp(linkPrimary, other.linkPrimary, t),
    );
  }
}

// Constants for commonly used values
class _AppTextStyleConstants {
  static const FontWeight baseFontWeight = FontWeight.w400;
  static const FontWeight boldFontWeight = FontWeight.w700;
  static const FontWeight buttonFontWeight = FontWeight.w500;
  static const FontWeight titleFontWeight = FontWeight.w600;
}

AppTextStyles getAppTextStyles({
  required Color defaultColor,
  required Color secondaryColor,
  required AppColors appColors,
}) {
  // Base text style that most other styles will extend from
  final baseTextStyle = TextStyle(
    color: defaultColor,
    fontSize: AppSizes.size16,
    fontWeight: _AppTextStyleConstants.baseFontWeight,
    letterSpacing: 0,
  );

  // Grey text style used by multiple text styles
  final greyTextStyle = baseTextStyle.copyWith(color: appColors.greyText);

  return AppTextStyles._(
    // Base styles
    regular: baseTextStyle.copyWith(color: appColors.secondary),
    bold: baseTextStyle.copyWith(
      fontWeight: _AppTextStyleConstants.boldFontWeight,
    ),
    boldLarge: baseTextStyle.copyWith(
      fontWeight: _AppTextStyleConstants.boldFontWeight,
      fontSize: AppSizes.size30,
      color: appColors.secondary,
    ),

    // Button style
    button: baseTextStyle.copyWith(
      fontSize: AppSizes.size16,
      fontWeight: _AppTextStyleConstants.buttonFontWeight,
    ),

    // Title style
    title: baseTextStyle.copyWith(
      fontSize: AppSizes.size30,
      fontWeight: _AppTextStyleConstants.titleFontWeight,
      color: secondaryColor,
    ),

    // Grey text styles (subtitle, label, divider)
    subtitle: greyTextStyle,
    label: greyTextStyle,
    divider: greyTextStyle,

    // Link styles
    link: baseTextStyle.copyWith(color: defaultColor),
    linkPrimary: baseTextStyle.copyWith(color: appColors.primaryLink),
  );
}
