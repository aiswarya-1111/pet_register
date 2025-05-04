import 'package:json_annotation/json_annotation.dart';

part 'pet_register_request_entity.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class PetRegisterRequestEntity {
  String petName;
  String userName;
  String petType;
  String gender;
  String location;

  PetRegisterRequestEntity({
    required this.petName,
    required this.userName,
    required this.petType,
    required this.gender,
    required this.location,
  });
  

  factory PetRegisterRequestEntity.fromJson(Map<String, dynamic> json) =>
      _$PetRegisterRequestEntityFromJson(json);
  Map<String, dynamic> toJson() => _$PetRegisterRequestEntityToJson(this);
}
