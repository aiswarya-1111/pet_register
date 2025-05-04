import 'package:cat_register/utils/color_resource.dart';
import 'package:cat_register/widget/custom_text.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final Icon? icon;
  final Color backgroundColor;
  final Color textColor;
  final double textFontSize;
  final FontWeight textFontWeight;
  final Color iconColor;

  const CustomButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
    this.backgroundColor = ColorResource.colorFFDC4E,
    this.textColor = ColorResource.color000000,
    this.iconColor = ColorResource.color000000,
    this.textFontSize = 16,
    this.textFontWeight = FontWeight.w500,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          foregroundColor: textColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          padding: const EdgeInsets.symmetric(vertical: 15),
          elevation: 0,
        ),
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment:
              icon != null
                  ? MainAxisAlignment.center
                  : MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[icon!, const SizedBox(width: 8)],
            CustomText(
              label,
              fontFamily: 'Inter',
              fontSize: textFontSize,
              fontWeight: textFontWeight,
            ),
          ],
        ),
      ),
    );
  }
}
