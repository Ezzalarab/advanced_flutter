import 'package:advanced_flutter/data/constants.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class DioFactory {
  Future<Dio> getDio() async {
    Dio dio = Dio();
    Map<String, String> headers = {
      DataConstants.contentType: DataConstants.applicationJson,
      DataConstants.accept: DataConstants.applicationJson,
      DataConstants.authorization: "SEND TOKEN HERE", // TODO send token here
      DataConstants.defaultLanguage: "en", // TODO get application language
    };

    dio.options = BaseOptions(
      baseUrl: DataConstants.baseUrl,
      headers: headers,
      sendTimeout: DataConstants.timeOut,
      receiveTimeout: DataConstants.timeOut,
    );

    if (kDebugMode) {
      dio.interceptors.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseHeader: true,
      ));
    }

    return dio;
  }
}
