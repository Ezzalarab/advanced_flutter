import 'package:advanced_flutter/data/constants.dart';
import 'package:dio/dio.dart';

class DioFactory {
  Future<Dio> getDio() async {
    Dio dio = Dio();
    Map<String, String> _headers = {
      DataConstants.contentType: DataConstants.applicationJson,
      DataConstants.accept: DataConstants.applicationJson,
      DataConstants.authorization: "SEND TOKEN HERE", // TODO send token here
      DataConstants.defaultLanguage: "en", // TODO get application language
    };

    dio.options = BaseOptions(
      baseUrl: DataConstants.baseUrl,
      headers: _headers,
      sendTimeout: DataConstants.timeOut,
      receiveTimeout: DataConstants.timeOut,
    );
    return dio;
  }
}
