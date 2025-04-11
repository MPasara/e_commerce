import 'package:flutter/material.dart';

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
    return ShopzyButton._(
      key: key,
      onPressed: onPressed,
      text: text,
      backgroundColor: const Color(0xff3669C9),
      disabledBackgroundColor: const Color(0xffC4C5C4),
    );
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
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        disabledBackgroundColor: disabledBackgroundColor,
        minimumSize: Size(double.infinity, height),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side:
              borderColor != null
                  ? BorderSide(color: borderColor!)
                  : BorderSide.none,
        ),
        elevation: 0,
      ),
      child: Text(
        text,
        style: TextStyle(
          color: textColor,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
