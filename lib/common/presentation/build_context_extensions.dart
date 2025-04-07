import 'package:flutter/material.dart';

import 'package:shopzy/theme/app_colors.dart';
import 'package:shopzy/theme/app_text_styles.dart';

extension BuildContextExtensions on BuildContext {
  AppTextStyles get appTextStyles => Theme.of(this).extension<AppTextStyles>()!;
  AppColors get appColors => Theme.of(this).extension<AppColors>()!;
}
