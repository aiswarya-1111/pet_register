// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pet_register_request_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PetRegisterRequestEntity _$PetRegisterRequestEntityFromJson(
  Map<String, dynamic> json,
) => PetRegisterRequestEntity(
  petName: json['pet_name'] as String,
  userName: json['user_name'] as String,
  petType: json['pet_type'] as String,
  gender: json['gender'] as String,
  location: json['location'] as String,
);

Map<String, dynamic> _$PetRegisterRequestEntityToJson(
  PetRegisterRequestEntity instance,
) => <String, dynamic>{
  'pet_name': instance.petName,
  'user_name': instance.userName,
  'pet_type': instance.petType,
  'gender': instance.gender,
  'location': instance.location,
};
