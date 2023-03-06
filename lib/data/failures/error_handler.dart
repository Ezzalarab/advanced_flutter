import 'package:advanced_flutter/data/failures/failure.dart';
import 'package:dio/dio.dart';

class ErrorHandler implements Exception {
  late Failure failure;

  ErrorHandler.handle(dynamic error) {
    if (error is DioError) {
      failure = _handleError(error);
    } else {
      // unknown error / default error
      failure = ErrorSource.unKnown.getFailure();
    }
  }
}

Failure _handleError(DioError error) {
  switch (error.type) {
    case DioErrorType.connectionTimeout:
      return ErrorSource.connectionTimeOut.getFailure();
    case DioErrorType.sendTimeout:
      return ErrorSource.sendTimeOut.getFailure();
    case DioErrorType.receiveTimeout:
      return ErrorSource.recieveTimeOut.getFailure();
    case DioErrorType.badCertificate:
      if (error.response != null) {
        if (error.response!.statusCode != null &&
            error.response!.statusMessage != null) {
          return Failure(
            code: error.response!.statusCode!,
            message: error.response!.statusMessage!,
          );
        } else {
          return ErrorSource.unKnown.getFailure();
        }
      } else {
        return ErrorSource.unKnown.getFailure();
      }
    case DioErrorType.badResponse:
      if (error.response != null) {
        if (error.response!.statusCode != null &&
            error.response!.statusMessage != null) {
          return Failure(
            code: error.response!.statusCode!,
            message: error.response!.statusMessage!,
          );
        } else {
          return ErrorSource.unKnown.getFailure();
        }
      } else {
        return ErrorSource.unKnown.getFailure();
      }
    case DioErrorType.cancel:
      return ErrorSource.cancle.getFailure();
    case DioErrorType.connectionError:
      return ErrorSource.noInternetConnection.getFailure();
    case DioErrorType.unknown:
      return ErrorSource.unKnown.getFailure();
  }
}

enum ErrorSource {
  success,
  noContent,
  badRequest,
  forbidden,
  unAuthorized,
  notFound,
  internalServerError,
  connectionTimeOut,
  cancle,
  recieveTimeOut,
  sendTimeOut,
  cacheError,
  noInternetConnection,
  unKnown,
}

extension DataSourceExtention on ErrorSource {
  Failure getFailure() {
    switch (this) {
      case ErrorSource.success:
        return Failure(
          code: ResponseCode.success,
          message: ResponseMessage.success,
        );
      case ErrorSource.noContent:
        return Failure(
          code: ResponseCode.noContent,
          message: ResponseMessage.noContent,
        );
      case ErrorSource.badRequest:
        return Failure(
          code: ResponseCode.badRequest,
          message: ResponseMessage.badRequest,
        );
      case ErrorSource.forbidden:
        return Failure(
          code: ResponseCode.success,
          message: ResponseMessage.success,
        );
      case ErrorSource.unAuthorized:
        return Failure(
          code: ResponseCode.success,
          message: ResponseMessage.success,
        );
      case ErrorSource.notFound:
        return Failure(
          code: ResponseCode.success,
          message: ResponseMessage.success,
        );
      case ErrorSource.internalServerError:
        return Failure(
          code: ResponseCode.success,
          message: ResponseMessage.success,
        );
      case ErrorSource.connectionTimeOut:
        return Failure(
          code: ResponseCode.success,
          message: ResponseMessage.success,
        );
      case ErrorSource.cancle:
        return Failure(
          code: ResponseCode.success,
          message: ResponseMessage.success,
        );
      case ErrorSource.recieveTimeOut:
        return Failure(
          code: ResponseCode.success,
          message: ResponseMessage.success,
        );
      case ErrorSource.sendTimeOut:
        return Failure(
          code: ResponseCode.success,
          message: ResponseMessage.success,
        );
      case ErrorSource.cacheError:
        return Failure(
          code: ResponseCode.success,
          message: ResponseMessage.success,
        );
      case ErrorSource.noInternetConnection:
        return Failure(
          code: ResponseCode.success,
          message: ResponseMessage.success,
        );
      case ErrorSource.unKnown:
        return Failure(
          code: ResponseCode.unknown,
          message: ResponseMessage.unknown,
        );
    }
  }
}

class ResponseCode {
  static const int success = 200;
  static const int noContent = 201;
  static const int badRequest = 400;
  static const int unAuthorized = 401;
  static const int forbidden = 403;
  static const int notFound = 404;
  static const int internalServerError = 200;

  // not standard
  static const int connectionTimeOut = -1;
  static const int cancle = -2;
  static const int recieveTimeOut = -3;
  static const int sendTimeOut = -4;
  static const int cacheError = -5;
  static const int noInternetConnection = -6;
  static const int unknown = -7;
}

class ResponseMessage {
  static const String success = "Success";
  static const String noContent = "Success, No Content";
  static const String badRequest = "Bad Request";
  static const String unAuthorized = "User Is Unaouthorized";
  static const String forbidden = "Forbidden Request";
  static const String notFound = "Not Found";
  static const String internalServerError =
      "Some Thing Whent Wrong, Try Again Later";

  static const String connectionTimeOut = "Time Out Error, Try Again Later";
  static const String cancle = "Request Was Cancelled";
  static const String recieveTimeOut = "Time Out Error";
  static const String sendTimeOut = "Time Out Error";
  static const String cacheError = "Cache Error";
  static const String noInternetConnection =
      "Please Check Your Internet Connection";
  static const String unknown = "Some Thing Whent Wrong, Try Again Later";
}
