import 'package:pet_register/utils/color_resource.dart';
import 'package:pet_register/utils/image_constant.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonEnum(valueField: "title")
enum PetGenderEnum {
  male("Male"),
  female("Female");

  final String title;
  const PetGenderEnum(this.title);

  String get image {
    switch (this) {
      case male:
        return ImageConstant.maleIcon;
      case female:
        return ImageConstant.femaleIcon;
    }
  }

  Color get bgColor {
    switch (this) {
      case male:
        return ColorResource.colorECF5FF;
      case female:
        return ColorResource.colorFFECF4;
    }
  }
}
