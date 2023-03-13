// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../../app/app_preferences.dart';
import '../../data/constants.dart';

class DioFactory {
  final AppPreferences _appPreferences;
  DioFactory(
    this._appPreferences,
  );

  Future<Dio> getDio() async {
    String appLanguage = await _appPreferences.getAppLanguage();

    Dio dio = Dio();
    Map<String, String> headers = {
      DataConstants.contentType: DataConstants.applicationJson,
      DataConstants.accept: DataConstants.applicationJson,
      DataConstants.authorization: "SEND TOKEN HERE", // TODO send token here
      DataConstants.defaultLanguage: appLanguage,
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
