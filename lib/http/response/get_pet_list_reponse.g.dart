// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_pet_list_reponse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetPetListReponse _$GetPetListReponseFromJson(Map<String, dynamic> json) =>
    GetPetListReponse(
      status: (json['status'] as num?)?.toInt() ?? 200,
      message: json['message'] as String?,
      error: json['error'] as String?,
      data:
          (json['data'] as List<dynamic>?)
              ?.map((e) => PetDetailEntity.fromJson(e as Map<String, dynamic>))
              .toList(),
    );

Map<String, dynamic> _$GetPetListReponseToJson(GetPetListReponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'error': instance.error,
      'data': instance.data,
    };
