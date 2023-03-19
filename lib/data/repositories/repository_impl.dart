// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:advanced_flutter/data/failures/error_handler.dart';
import 'package:advanced_flutter/data/mappers/mapper.dart';
import 'package:dartz/dartz.dart';

import 'package:advanced_flutter/data/data_sources/local_ds.dart';
import 'package:advanced_flutter/data/data_sources/remote_ds.dart';
import 'package:advanced_flutter/data/network/network_info.dart';

import '../../domain/entities/auth.dart';
import '../../domain/repositories/repository.dart';
import '../failures/failure.dart';
import '../requestes/login_request.dart';

class RepositoryImpl implements Repository {
  NetworkInfoImpl _networkInfoImpl;
  RemoteDSImpl _remoteDSImpl;
  LocalDSImpl _localDSImpl;
  RepositoryImpl(
    this._networkInfoImpl,
    this._remoteDSImpl,
    this._localDSImpl,
  );

  @override
  Future<Either<Failure, Auth>> login(LoginRequest loginRequest) async {
    if (await _networkInfoImpl.isConeected) {
      try {
        final authResponse = await _remoteDSImpl.login(loginRequest);
        if (authResponse.status == ApiInternalStatus.success) {
          return Right(authResponse.toDomain());
        } else {
          return Left(Failure(
              code: ApiInternalStatus.failure,
              message: authResponse.message ?? ResponseMessage.unknown));
        }
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      return Left(ErrorSource.noInternetConnection.getFailure());
    }
  }
}
