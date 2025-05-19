import 'package:flutter/material.dart';
import 'package:shopzy/common/presentation/build_context_extensions.dart';
import 'package:shopzy/theme/app_colors.dart';

class ShopzyButton extends StatelessWidget {
  const ShopzyButton._({
    super.key,
    required this.onPressed,
    required this.text,
    this.backgroundColor,
    this.disabledBackgroundColor,
    this.borderColor,
    this.textColor = Colors.white,
    this.height = 50,
  });

  final VoidCallback? onPressed;
  final String text;
  final Color? backgroundColor;
  final Color? disabledBackgroundColor;
  final Color? borderColor;
  final Color textColor;
  final double height;

  factory ShopzyButton.primary({
    Key? key,
    required VoidCallback? onPressed,
    required String text,
  }) {
    return ShopzyButton._(key: key, onPressed: onPressed, text: text);
  }

  factory ShopzyButton.secondary({
    Key? key,
    required VoidCallback? onPressed,
    required String text,
  }) {
    return ShopzyButton._(
      key: key,
      onPressed: onPressed,
      text: text,
      backgroundColor: Colors.transparent,
      disabledBackgroundColor: Colors.transparent,
      borderColor: Colors.black,
      textColor: Colors.black,
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColors>();

    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor ?? colors?.appButtonPrimaryBackground,
        disabledBackgroundColor:
            disabledBackgroundColor ?? colors?.appButtonDisabled,
        minimumSize: Size(double.infinity, height),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          side:
              borderColor != null
                  ? BorderSide(color: borderColor!)
                  : BorderSide.none,
        ),
        elevation: 0,
      ),
      child: Text(
        text,
        style: context.appTextStyles.button?.copyWith(color: textColor),
      ),
    );
  }
}
