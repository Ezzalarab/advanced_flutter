import 'package:dartz/dartz.dart';

import '../../domain/entities/auth.dart';
import '../../domain/repositories/repository.dart';
import '../failures/error_handler.dart';
import '../mappers/mapper.dart';
import '../data_sources/local_ds.dart';
import '../data_sources/remote_ds.dart';
import '../network/network_info.dart';
import '../failures/failure.dart';
import '../requestes/login_request.dart';

class RepositoryImpl implements Repository {
  final NetworkInfo _networkInfo;
  final RemoteDS _remoteDS;
  final LocalDS _localDS;
  RepositoryImpl(
    this._networkInfo,
    this._remoteDS,
    this._localDS,
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
  Future<Either<Failure, Auth>> forgotPassword(String email) async {
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
}
