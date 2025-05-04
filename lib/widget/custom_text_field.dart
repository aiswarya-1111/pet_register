// ignore_for_file: library_private_types_in_public_api

import 'package:pet_register/utils/color_resource.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController? controller;

  final String? hintText;
  final double hintTextSize;
  final Color? hintTextColor;
  final String hintTextFont;
  final FontWeight hintFontWeight;

  final double inputTextSize;
  final Color? inputTextcolor;
  final FontWeight inputFontWeight;
  final bool obscureText;
  final TextAlign textAlign;
  final Color? fillColor;

  final double? height;
  final double? width;
  final double verticalMargin;
  final double horizontalMargin;
  final double borderRadius;
  final Color? borderColor;
  final double borderWidth;
  final double horizontalPadding;
  final int? maxLines;
  final int? minLines;
  final int? maxLength;

  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final Function(String)? onChanged;
  final TextInputType? textInputType;
  final bool autofocus;
  final TextCapitalization textCapitalization;
  final InputBorder border;
  final bool focusBorder;
  final bool enabled;
  final Iterable<String>? autofillHints;

  final EdgeInsetsGeometry? contentPadding;
  final List<TextInputFormatter>? inputFormatters;

  final FocusNode? focusNode;
  final BoxConstraints prefixConstraints;

  final ValueChanged<String>? onSubmitted;
  final String font;
  final EdgeInsets scrollPadding;
  final String? validatorMessage;

  const CustomTextField({
    this.controller,
    this.hintText,
    this.hintTextSize = 14,
    this.hintTextColor = ColorResource.colorB0B0B0,
    this.hintTextFont = "Inter",
    this.hintFontWeight = FontWeight.normal,
    this.inputTextSize = 14,
    this.inputTextcolor,
    this.inputFontWeight = FontWeight.normal,
    this.fillColor = ColorResource.colorF9FAFB,
    this.verticalMargin = 0,
    this.horizontalMargin = 0,
    this.borderRadius = 5,
    this.horizontalPadding = 16,
    this.suffixIcon,
    this.onChanged,
    this.textInputType,
    this.borderColor = ColorResource.colorEBECEF,
    this.scrollPadding = const EdgeInsets.all(20.0),
    this.borderWidth = 1,
    this.obscureText = false,
    this.autofocus = false,
    this.height,
    this.width,
    this.textCapitalization = TextCapitalization.none,
    this.maxLines = 1,
    this.border = InputBorder.none,
    this.focusBorder = false,
    this.minLines,
    this.enabled = true,
    this.autofillHints,
    this.prefixIcon,
    this.contentPadding,
    this.inputFormatters,
    this.maxLength,
    this.focusNode,
    this.onSubmitted,
    this.validatorMessage = "Required",
    this.textAlign = TextAlign.start,
    this.font = "Inter",
    this.prefixConstraints = const BoxConstraints(maxHeight: 24, maxWidth: 30),
    super.key,
  });

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  FocusNode textFieldFocus = FocusNode();
  Color? focusColor;
  @override
  void initState() {
    focusColor = widget.borderColor;
    if (widget.focusNode != null) {
      textFieldFocus = widget.focusNode!;
    }
    textFieldFocus.addListener(() {
      if (textFieldFocus.hasFocus && widget.focusBorder) {
        setState(() {
          focusColor = ColorResource.colorEBECEF;
        });
      } else {
        focusColor = widget.borderColor;
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      width: widget.width,
      margin: EdgeInsets.symmetric(
        vertical: widget.verticalMargin,
        horizontal: widget.horizontalMargin,
      ),
      padding: EdgeInsets.symmetric(horizontal: widget.horizontalPadding),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(widget.borderRadius),
        color: widget.fillColor,
        border:
            focusColor != null
                ? Border.all(color: focusColor!, width: widget.borderWidth)
                : null,
      ),
      child: Center(
        child: Theme(
          data: ThemeData().copyWith(
            textSelectionTheme: const TextSelectionThemeData(
              selectionHandleColor: Colors.transparent,
            ),
          ),
          child: TextFormField(
            textAlign: widget.textAlign,
            enabled: widget.enabled,
            controller: widget.controller,
            autofocus: widget.autofocus,
            keyboardType: widget.textInputType,
            obscureText: widget.obscureText,
            maxLines: widget.maxLines,
            focusNode: textFieldFocus,
            minLines: widget.minLines,
            scrollPadding: widget.scrollPadding,
            autofillHints: widget.autofillHints,
            textCapitalization: widget.textCapitalization,
            inputFormatters: widget.inputFormatters,
            cursorColor: ColorResource.color000000,
            validator:
                widget.validatorMessage != null
                    ? (value) {
                      return value!.trim().isEmpty
                          ? widget.validatorMessage
                          : null;
                    }
                    : null,
            maxLength: widget.maxLength,
            style: TextStyle(
              fontFamily: widget.font,
              color: widget.inputTextcolor,
              fontSize: widget.inputTextSize,
              fontWeight: widget.inputFontWeight,
            ),
            onChanged: widget.onChanged,
            onFieldSubmitted: widget.onSubmitted,
            decoration: InputDecoration(
              focusedBorder: widget.border,
              enabledBorder: widget.border,
              border: widget.border,
              hintText: widget.hintText,
              hintStyle: TextStyle(
                fontFamily: widget.hintTextFont,
                color: widget.hintTextColor,
                fontSize: widget.hintTextSize,
                fontWeight: widget.hintFontWeight,
              ),
              contentPadding: widget.contentPadding,
              prefixIcon: widget.prefixIcon,
              prefixIconConstraints: widget.prefixConstraints,
              suffixIcon: widget.suffixIcon,
              suffixIconConstraints: const BoxConstraints(
                maxHeight: 24,
                maxWidth: 24,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
