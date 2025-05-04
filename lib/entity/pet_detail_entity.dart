import 'package:pet_register/utils/enum.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:pet_register/utils/equatable.dart';

part 'pet_detail_entity.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class PetDetailEntity extends BaseEquatable {
  int? id;
  String? userName;
  String? petName;
  String? petType;
  PetGenderEnum? gender;
  String? location;
  String? image;
  String? createdAt;
  String? updatedAt;
  String? imageUrl;

  PetDetailEntity({
    this.id,
    this.userName,
    this.petName,
    this.petType,
    this.gender,
    this.location,
    this.image,
    this.createdAt,
    this.updatedAt,
    this.imageUrl,
  });

  @override
  List<Object?> get props => [id];

  factory PetDetailEntity.fromJson(Map<String, dynamic> json) =>
      _$PetDetailEntityFromJson(json);

  Map<String, dynamic> toJson() => _$PetDetailEntityToJson(this);
}
