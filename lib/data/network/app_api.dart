import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';

import '../constants.dart';
import '../responses/responses.dart';

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

  @POST("/customers/register")
  Future<AuthResponse> register(
    @Field("user_name") String userName,
    @Field("country_mobile_code") String countryMobileCode,
    @Field("mobile_number") String mobileNumber,
    @Field("email") String email,
    @Field("password") String password,
    @Field("profile_picture") String profilePicture,
  );
}
