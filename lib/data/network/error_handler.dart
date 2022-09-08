import 'package:dio/dio.dart';
import 'package:tut_app/data/network/failure.dart';
import 'package:tut_app/presentation/resources/strings_manager.dart';
import 'package:easy_localization/easy_localization.dart';

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

// API response codes
class ResponseMessage {
  // success with data
  static const String success = AppStrings.success;

  // Success with no content
  static const String noContent = AppStrings.noContent;

  // failure, api rejected the request
  static const String badRequest = AppStrings.badRequestError;

  // failure, api rejected the request
  static const String forbidden = AppStrings.forbiddenError;

  // failure user is not authorised
  static const String unauthorized = AppStrings.unauthorizedError;

  // failure, api url is not correct and not found
  static const String notFound = AppStrings.notFoundError;

  // failure, crash happened in server side
  static const String internalServerError = AppStrings.internalServerError;

  // local response codes

  // unknown error happened
  static const String defaultError = AppStrings.defaultError;

  // issue in connectivity
  static const String connectTimeout = AppStrings.timeoutError;

  // API request was cancelled
  static const String cancel = AppStrings.cancelRequest;

  // issue in connectivity
  static const String receiveTimeout = AppStrings.timeoutError;

  // issue in connectivity
  static const String sendTimeout = AppStrings.timeoutError;

  // issue in getting data from local data source (cache)
  static const String cacheError = AppStrings.cacheError;

  // issue in connectivity
  static const String noInternetConnection = AppStrings.noInternetError;
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
          ResponseMessage.badRequest.tr(),
        );
      case DataSource.unauthorized:
        return Failure(
          ResponseCode.unauthorized,
          ResponseMessage.unauthorized.tr(),
        );
      case DataSource.notFound:
        return Failure(
          ResponseCode.notFound,
          ResponseMessage.notFound.tr(),
        );
      case DataSource.internalServerError:
        return Failure(
          ResponseCode.internalServerError,
          ResponseMessage.internalServerError.tr(),
        );
      case DataSource.connectTimeout:
        return Failure(
          ResponseCode.connectTimeout,
          ResponseMessage.connectTimeout.tr(),
        );
      case DataSource.cancel:
        return Failure(
          ResponseCode.cancel,
          ResponseMessage.cancel.tr(),
        );
      case DataSource.receiveTimeout:
        return Failure(
          ResponseCode.receiveTimeout,
          ResponseMessage.receiveTimeout.tr(),
        );
      case DataSource.sendTimeout:
        return Failure(
          ResponseCode.sendTimeout,
          ResponseMessage.sendTimeout.tr(),
        );
      case DataSource.cacheError:
        return Failure(
          ResponseCode.cacheError,
          ResponseMessage.cacheError.tr(),
        );
      case DataSource.noInternetConnection:
        return Failure(
          ResponseCode.noInternetConnection,
          ResponseMessage.noInternetConnection.tr(),
        );
      case DataSource.defaultError:
        return Failure(
          ResponseCode.defaultError,
          ResponseMessage.defaultError.tr(),
        );
      default:
        return Failure(
          ResponseCode.defaultError,
          ResponseMessage.defaultError.tr(),
        );
    }
  }
}
