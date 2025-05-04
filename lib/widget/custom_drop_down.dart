import 'package:cat_register/utils/color_resource.dart';
import 'package:cat_register/widget/custom_text.dart';
import 'package:flutter/material.dart';

class CustomDropDownWidget<T> extends StatelessWidget {
  final List<T> items;
  final String? Function(T) displayName;
  final void Function(T) onChanged;
  final T? selectedValue;
  final Color color;
  final Color? fillColor;
  final Color iconColor;
  final String? hintText;
  final int maxChars;
  final Color fontColor;
  final Color hintColor;
  final double hintFontSize;
  final FontWeight hintFontWeight;
  final Color borderColor;
  final double fontSize;
  const CustomDropDownWidget({
    super.key,
    required this.items,
    required this.displayName,
    required this.onChanged,
    required this.selectedValue,
    this.hintText,
    this.fillColor = ColorResource.colorF9FAFB,
    this.color = Colors.white,
    this.iconColor = ColorResource.color252525,
    this.fontColor = ColorResource.color252525,
    this.hintColor = ColorResource.colorB0B0B0,
    this.hintFontSize = 14,
    this.hintFontWeight = FontWeight.normal,
    this.maxChars = 25,
    this.borderColor = ColorResource.colorEBECEF,
    this.fontSize = 14,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<T>(
      borderRadius: BorderRadius.circular(20),
      isExpanded: false,
      dropdownColor: ColorResource.colorFFFFFF,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(horizontal: 11, vertical: 0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(color: ColorResource.colorEBECEF),
        ),
        fillColor: ColorResource.colorF9FAFB,
        filled: true,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(color: ColorResource.colorEBECEF),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(color: ColorResource.colorEBECEF),
        ),
      ),
      icon: Icon(Icons.keyboard_arrow_down_rounded, color: iconColor),
      hint: CustomText(
        hintText ?? "Select",
        color: hintColor,
        fontWeight: hintFontWeight,
      ),
      value: selectedValue,
      selectedItemBuilder: ((context) {
        return List.generate(
          items.length,
          (index) => CustomText(
            displayName(items[index]).toString(),
            color: fontColor,
          ),
        );
      }),
      items: List.generate(items.length, (index) {
        return DropdownMenuItem(
          value: items[index],
          child: CustomText(displayName(items[index]).toString()),
        );
      }),
      onChanged: (value) => onChanged(value as T),
    );
  }
}
