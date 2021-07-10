import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

class DioHelper {
  static Dio dio;
  static init() {
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://student.valuxapps.com/api/',
        receiveDataWhenStatusError: true,
        headers: {
          'Content-Type': 'application/json',
          'lang': 'en',
        }
      ),
    );
  }

  static Future<Response> getData({
    @required String url,
    @required Map<String, dynamic> query,
    String lang = 'en',
    String authorization,
  }) async {
    dio.options.headers = {
      'land': lang,
      'Authorization': authorization,
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
      'land': lang,
      'Authorization': authorization,
    };
    return await dio.post(
      url,
      data: data,
      queryParameters: query,
    );
  }
}
