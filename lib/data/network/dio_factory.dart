import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:tut_app/app/constant.dart';

const String applicationJson = "application/json";
const String contentType = "content-type";
const String accept = "accept";
const String authorization = "authorization";
const String defaultLanguage = "language";

class DioFactory {
  Future<Dio> getDio() async {
    Dio dio = Dio();
    int timeOut = 60 * 1000; // 1 min
    Map<String, String> headers = {
      contentType: applicationJson,
      accept: applicationJson,
      authorization: Constant.token,
      defaultLanguage: "en" // todo get lang from app prefs
    };

    dio.options = BaseOptions(
        baseUrl: Constant.baseUrl,
        connectTimeout: timeOut,
        receiveTimeout: timeOut,
        headers: headers);

    if (kReleaseMode) {
      print("Release mode no logs");
    } else {
      dio.interceptors.add(
        PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
          responseHeader: true,
        ),
      );
    }
    return dio;
  }
}
