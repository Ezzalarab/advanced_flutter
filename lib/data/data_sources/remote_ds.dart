// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';

import 'package:advanced_flutter/data/network/app_api.dart';

import '../failures/failure.dart';
import '../requestes/login_request.dart';
import '../responses/responses.dart';

abstract class RemoteDS {
  Future<AuthResponse> login(LoginRequest loginRequest);
}

class RemoteDSImpl implements RemoteDS {
  AppServiceClient _appServiceClient;
  RemoteDSImpl(this._appServiceClient);
  @override
  Future<AuthResponse> login(LoginRequest loginRequest) async {
    return await _appServiceClient.login(
        loginRequest.email, loginRequest.password);
  }
}
