import 'package:pet_register/http/http.urls.dart';
import 'package:dio/dio.dart';

class DioHelper {
  Dio dio = Dio();

  DioHelper() {
    _init();
  }

  void _init() {
    dio = Dio();
    dio.options.baseUrl = HttpUrls.baseUrl;
  }
}

final DioHelper dioHelper = DioHelper();
final Dio dio = dioHelper.dio;
