// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pet_detail_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PetDetailEntity _$PetDetailEntityFromJson(Map<String, dynamic> json) =>
    PetDetailEntity(
      id: (json['id'] as num?)?.toInt(),
      userName: json['user_name'] as String?,
      petName: json['pet_name'] as String?,
      petType: json['pet_type'] as String?,
      gender: $enumDecodeNullable(_$PetGenderEnumEnumMap, json['gender']),
      location: json['location'] as String?,
      image: json['image'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      imageUrl: json['image_url'] as String?,
    );

Map<String, dynamic> _$PetDetailEntityToJson(PetDetailEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user_name': instance.userName,
      'pet_name': instance.petName,
      'pet_type': instance.petType,
      'gender': _$PetGenderEnumEnumMap[instance.gender],
      'location': instance.location,
      'image': instance.image,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'image_url': instance.imageUrl,
    };

const _$PetGenderEnumEnumMap = {
  PetGenderEnum.male: 'Male',
  PetGenderEnum.female: 'Female',
};
