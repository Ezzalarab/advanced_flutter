import 'package:advanced_flutter/data/data_sources/local_ds.dart';
import 'package:dartz/dartz.dart';

import '../../domain/entities/auth.dart';
import '../../domain/repositories/repository.dart';
import '../data_sources/remote_ds.dart';
import '../failures/error_handler.dart';
import '../failures/failure.dart';
import '../mappers/mapper.dart';
import '../network/network_info.dart';
import '../requestes/login_request.dart';

class RepositoryImpl implements Repository {
  final NetworkInfo _networkInfo;
  final RemoteDS _remoteDS;
  RepositoryImpl(
    this._networkInfo,
    this._remoteDS,
    LocalDSImpl localDSImpl,
  );

  @override
  Future<Either<Failure, Auth>> login(LoginRequest loginRequest) async {
    if (await _networkInfo.isConeected) {
      try {
        final authResponse = await _remoteDS.login(loginRequest);
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

  @override
  Future<Either<Failure, String>> forgotPassword(String email) async {
    if (await _networkInfo.isConeected) {
      try {
        final resetPasswordResponse = await _remoteDS.forgotPassword(email);
        if (resetPasswordResponse.status == ApiInternalStatus.success) {
          return Right(resetPasswordResponse.toDomain());
        } else {
          return Left(Failure(
              code: ApiInternalStatus.failure,
              message:
                  resetPasswordResponse.message ?? ResponseMessage.unknown));
        }
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      return Left(ErrorSource.noInternetConnection.getFailure());
    }
  }

  @override
  Future<Either<Failure, Auth>> register(RegisterRequest register) async {
    if (await _networkInfo.isConeected) {
      try {
        final authResponse = await _remoteDS.register(register);
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
