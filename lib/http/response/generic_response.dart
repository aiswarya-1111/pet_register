import 'package:cat_register/http/response/base_response.dart';
import 'package:json_annotation/json_annotation.dart';
part 'generic_response.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class GenericResponse extends BaseResponse {
  GenericResponse({super.status, super.message, super.error});

  factory GenericResponse.fromJson(Map<String, dynamic> json) =>
      _$GenericResponseFromJson(json);
  Map<String, dynamic> toJson() => _$GenericResponseToJson(this);
}
