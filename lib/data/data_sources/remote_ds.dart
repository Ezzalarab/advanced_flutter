import '../network/app_api.dart';
import '../requestes/login_request.dart';
import '../responses/responses.dart';

abstract class RemoteDS {
  Future<AuthResponse> login(LoginRequest loginRequest);
  Future<AuthResponse> forgotPassword(String email);
}

class RemoteDSImpl implements RemoteDS {
  final AppServiceClient _appServiceClient;
  RemoteDSImpl(this._appServiceClient);

  @override
  Future<AuthResponse> login(LoginRequest loginRequest) async {
    return await _appServiceClient.login(
        loginRequest.email, loginRequest.password);
  }

  @override
  Future<AuthResponse> forgotPassword(String email) async {
    return await _appServiceClient.fotgotPassword(email);
  }
}
