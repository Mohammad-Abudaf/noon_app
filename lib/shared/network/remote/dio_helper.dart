import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

class DioHelper {
  static Dio dio;
  static init() {
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://student.valuxapps.com/api/',
        receiveDataWhenStatusError: true,
      ),
    );
  }

  static Future<Response> getData({
    @required String url,
    Map<String, dynamic> query,
    String lang = 'en',
    String authorization,
  }) async {
    dio.options.headers = {
      'Content-Type': 'application/json',
      'land': lang,
      'Authorization': authorization?? '',
    };
    return await dio.get(url, queryParameters: query);
  }

  static Future<Response> postData({
    @required String url,
    @required Map<String, dynamic> data,
    Map<String, dynamic> query,
    String lang = 'ar',
    String authorization,
  }) async {
    dio.options.headers = {
      'Content-Type' : 'application/json',
      'land': 'en',
      'Authorization': authorization?? '',
    };
    return await dio.post(
      url,
      data: data,
      queryParameters: query,
    );
  }
}
