import 'package:advanced_flutter/data/responses/responses.dart';

import '../constants.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
part 'app_api.g.dart';

@RestApi(baseUrl: DataConstants.baseUrl)
abstract class AppServiceClient {
  factory AppServiceClient(
    Dio dio, {
    String baseUrl,
  }) = _AppServiceClient;

  @POST("/customers/login")
  Future<AuthResponse> login(
    @Field("email") String email,
    @Field("password") String password,
  );
}
