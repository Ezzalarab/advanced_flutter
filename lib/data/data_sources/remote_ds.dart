import '../network/app_api.dart';
import '../requestes/login_request.dart';
import '../responses/responses.dart';

abstract class RemoteDS {
  Future<AuthResponse> login(LoginRequest loginRequest);
}

class RemoteDSImpl implements RemoteDS {
  final AppServiceClient _appServiceClient;
  RemoteDSImpl(this._appServiceClient);

  @override
  Future<AuthResponse> login(LoginRequest loginRequest) async {
    return await _appServiceClient.login(
        loginRequest.email, loginRequest.password);
  }
}
