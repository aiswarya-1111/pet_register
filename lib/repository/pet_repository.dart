import 'dart:io';

import 'package:pet_register/http/dio.dart';
import 'package:pet_register/http/http.urls.dart';
import 'package:pet_register/http/response/generic_response.dart';
import 'package:pet_register/http/response/get_pet_list_reponse.dart';
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:path/path.dart' as path;

class PetRepository {
  PetRepository._();

  static Future<GenericResponse> registerPet({
    required String petName,
    required String userName,
    required String petType,
    required String gender,
    required String location,
    required File imageFile,
  }) async {
    try {
      final fileName = path.basename(imageFile.path);
      final multipartFile = await MultipartFile.fromFile(
        imageFile.path,
        filename: fileName,
        contentType: MediaType("image", "png"),
      );

      final formData = FormData.fromMap({
        'pet_name': petName,
        'user_name': userName,
        'pet_type': petType,
        'gender': gender,
        'location': location,
        'image': multipartFile,
      });

      final response = await dio.post(
        HttpUrls.registerFormUrl,
        data: formData,
        options: Options(contentType: 'multipart/form-data'),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return GenericResponse.fromJson(response.data as Map<String, dynamic>);
      } else {
        throw Exception('Failed to register pet: ${response.data}');
      }
    } catch (e) {
      throw Exception('Failed to fetch pet list');
    }
  }

  static Future<GetPetListReponse> fetchPetList() async {
    try {
      final response = await dio.get(HttpUrls.getPetformUrl);
      return GetPetListReponse.fromJson(response.data as Map<String, dynamic>);
    } catch (e) {
      throw Exception('Failed to fetch pet list');
    }
  }
}
