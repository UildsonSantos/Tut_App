import 'package:dio/dio.dart';
import 'package:tut_app/data/network/failure.dart';

enum DataSource {
  success,
  noContent,
  badRequest,
  forbidden,
  unauthorized,
  notFound,
  internalServerError,
  connectTimeout,
  cancel,
  receiveTimeout,
  sendTimeout,
  cacheError,
  noInternetConnection,
  defaultError
}

class ErrorHandler implements Exception {
  late Failure failure;

  ErrorHandler.handle(dynamic error) {
    if (error is DioError) {
      // dio error so its error from response of the API
      failure = _handleError(error);
    } else {
      // default error
      failure = DataSource.defaultError.getFailure();
    }
  }

  Failure _handleError(DioError dioError) {
    switch (dioError.type) {
      case DioErrorType.connectTimeout:
        return DataSource.connectTimeout.getFailure();
      case DioErrorType.sendTimeout:
        return DataSource.sendTimeout.getFailure();
      case DioErrorType.receiveTimeout:
        return DataSource.receiveTimeout.getFailure();
      case DioErrorType.response:
        switch (dioError.response?.statusCode) {
          case ResponseCode.badRequest:
            return DataSource.badRequest.getFailure();
          case ResponseCode.forbidden:
            return DataSource.forbidden.getFailure();
          case ResponseCode.unauthorized:
            return DataSource.unauthorized.getFailure();
          case ResponseCode.notFound:
            return DataSource.notFound.getFailure();
          case ResponseCode.internalServerError:
            return DataSource.internalServerError.getFailure();
          default:
            return DataSource.defaultError.getFailure();
        }
      case DioErrorType.cancel:
        return DataSource.cancel.getFailure();
      case DioErrorType.other:
        return DataSource.defaultError.getFailure();
    }
  }
}

class ResponseCode {
  static const int success = 200; // success with data
  static const int noContent = 201; // success with no content
  static const int badRequest = 400; // failure, api rejected the request
  static const int forbidden = 403; // failure, api rejected the request
  static const int unauthorized = 401; // failure user is not authorised
  static const int notFound =
      404; // failure, api url is not correct and not found
  static const int internalServerError =
      500; // failure, crash happened in server side

  // local status code
  static const int defaultError = -1;
  static const int connectTimeout = -2;
  static const int cancel = -3;
  static const int receiveTimeout = -4;
  static const int sendTimeout = -5;
  static const int cacheError = -6;
  static const int noInternetConnection = -7;
}

class ResponseMessage {
  // API status codes
  static const String success = "Success"; // success with data
  static const String noContent =
      "Success with no content"; // success with no content
  static const String badRequest =
      "Bad request, try again later"; // failure, api rejected the request
  static const String forbidden =
      "Forbidden request, try again later"; // failure, api rejected the request
  static const String unauthorized =
      "User is unauthorised, try again later"; // failure user is not authorised
  static const String notFound =
      "Url is not found, try again later"; // failure, api url is not correct and not found
  static const String internalServerError =
      "Some thing went wrong, try again later"; // failure, crash happened in server side

  // local status code
  static const String defaultError = "Some thing went wrong, try again later";
  static const String connectTimeout = "Time out error, try again later";
  static const String cancel = "Request was cancelled, try again later";
  static const String receiveTimeout = "Time out error, try again later";
  static const String sendTimeout = "Time out error, try again later";
  static const String cacheError = "Cache error, try again later";
  static const String noInternetConnection =
      "Please check your internet connection";
}

class ApiInternalStatus {
  static const int success = 0;
  static const int failure = 1;
}

extension DataSourceExtension on DataSource {
  Failure getFailure() {
    switch (this) {
      case DataSource.badRequest:
        return Failure(
          ResponseCode.badRequest,
          ResponseMessage.badRequest,
        );
      case DataSource.unauthorized:
        return Failure(
          ResponseCode.unauthorized,
          ResponseMessage.unauthorized,
        );
      case DataSource.notFound:
        return Failure(
          ResponseCode.notFound,
          ResponseMessage.notFound,
        );
      case DataSource.internalServerError:
        return Failure(
          ResponseCode.internalServerError,
          ResponseMessage.internalServerError,
        );
      case DataSource.connectTimeout:
        return Failure(
          ResponseCode.connectTimeout,
          ResponseMessage.connectTimeout,
        );
      case DataSource.cancel:
        return Failure(
          ResponseCode.cancel,
          ResponseMessage.cancel,
        );
      case DataSource.receiveTimeout:
        return Failure(
          ResponseCode.receiveTimeout,
          ResponseMessage.receiveTimeout,
        );
      case DataSource.sendTimeout:
        return Failure(
          ResponseCode.sendTimeout,
          ResponseMessage.sendTimeout,
        );
      case DataSource.cacheError:
        return Failure(
          ResponseCode.cacheError,
          ResponseMessage.cacheError,
        );
      case DataSource.noInternetConnection:
        return Failure(
          ResponseCode.noInternetConnection,
          ResponseMessage.noInternetConnection,
        );
      case DataSource.defaultError:
        return Failure(
          ResponseCode.defaultError,
          ResponseMessage.defaultError,
        );
      default:
        return Failure(
          ResponseCode.defaultError,
          ResponseMessage.defaultError,
        );
    }
  }
}