import 'package:pet_register/utils/color_resource.dart';
import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String? text;
  final double? fontSize;
  final String? fontFamily;
  final Color? color;
  final TextAlign? textAlign;
  final GestureTapCallback? onTap;
  final bool? showEllipsis;
  final int? maxLines;
  final double? height;
  final double? decorationThickness;
  final FontWeight fontWeight;
  final FontStyle fontStyle;
  final bool isSingleLine;
  final TextOverflow? textOverflow;
  final TextDecorationStyle? decorationStyle;
  final Color? decorationColor;
  final int? minTextLength;
  final double? letterSpacing;

  const CustomText(
    this.text, {
    super.key,
    this.fontSize = 14,
    this.color = ColorResource.color000000,
    this.textAlign = TextAlign.left,
    this.showEllipsis = false,
    this.isSingleLine = false,
    this.maxLines,
    this.fontWeight = FontWeight.normal,
    this.height,
    this.decorationThickness = 2,
    this.fontStyle = FontStyle.normal,
    this.onTap,
    this.textOverflow,
    this.decorationStyle,
    this.decorationColor,
    this.minTextLength,
    this.letterSpacing = 0,
    this.fontFamily = "Inter",
  });

  @override
  Widget build(BuildContext context) {
    TextDecoration decoration = TextDecoration.none;
    final Text textWidget = Text(
      (minTextLength != null && text != null)
          ? shortTextWithDottedSuffix()
          : text ?? "",
      textAlign: textAlign,
      overflow: showEllipsis! ? TextOverflow.ellipsis : textOverflow,
      maxLines: maxLines,
      softWrap: true,
      style: TextStyle(
        fontFamily: fontFamily,
        color: color,
        decoration: decoration,
        decorationColor: decorationColor,
        decorationStyle: decorationStyle,
        decorationThickness: decorationThickness,
        fontSize: fontSize,
        fontStyle: fontStyle,
        fontWeight: fontWeight,
        overflow: isSingleLine ? TextOverflow.ellipsis : textOverflow,
        letterSpacing: letterSpacing,
        height: height,
      ),
    );

    if (onTap != null) {
      return GestureDetector(onTap: onTap, child: textWidget);
    } else {
      return textWidget;
    }
  }

  String shortTextWithDottedSuffix() {
    if (minTextLength! > 0 && minTextLength! >= text!.length) {
      return text!;
    }
    return text!.replaceRange(minTextLength!, text!.length, "...");
  }
}
