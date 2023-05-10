import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';

import '../responses/responses.dart';
import '../constants.dart';

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

  @POST("/customers/forgot_password")
  Future<ForgotPasswordResponse> fotgotPassword(@Field("email") String email);
}
