import 'package:pet_register/entity/pet_detail_entity.dart';
import 'package:pet_register/http/response/generic_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_pet_list_reponse.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class GetPetListReponse extends GenericResponse {
  List<PetDetailEntity>? data;

  GetPetListReponse({super.status, super.message, super.error, this.data});

  factory GetPetListReponse.fromJson(Map<String, dynamic> json) =>
      _$GetPetListReponseFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$GetPetListReponseToJson(this);
}
