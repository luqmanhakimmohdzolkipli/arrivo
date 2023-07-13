import 'dart:developer';

import 'package:arrivo_task/app/constant/api_constant.dart';
import 'package:dio/dio.dart';

class ApiService {
  final Dio dio = Dio();
  final String baseUrl = ApiConstant.baseUrl;

  Future<Response> get(
    String endpoint, {
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      Response response = await dio.get(
        baseUrl + endpoint,
        queryParameters: queryParameters,
      );
      log('get response >>> ${response}');
      return response;
    } on DioException catch (e) {
      log('get error >>> $e');
      rethrow;
    }
  }

  Future<Response> delete(
      String endpoint, {
        Map<String, dynamic>? queryParameters,
      }) async {
    try {
      log('delete url >>> $baseUrl$endpoint');
      Response response = await dio.delete(
        baseUrl + endpoint,
        queryParameters: queryParameters,
      );
      log('delete response >>> ${response}');
      return response;
    } on DioException catch (e) {
      log('delete error >>> $e');
      rethrow;
    }
  }
}
