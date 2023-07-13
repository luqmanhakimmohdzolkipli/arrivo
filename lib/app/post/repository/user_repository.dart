import 'dart:async';
import 'dart:convert';

import 'package:arrivo_task/app/constant/api_constant.dart';
import 'package:arrivo_task/app/data/api/api_service.dart';
import 'package:arrivo_task/app/post/model/user_model.dart';
import 'package:dio/dio.dart';

class UserRepository {
  final ApiService apiService = ApiService();


  Future<List<UserModel>> fetchAllUsers() async {
    await Future.delayed(Duration(seconds: 1));
    Response response = await apiService.get(ApiConstant.user);
    List<UserModel> userModel = userModelFromJson(jsonEncode(response.data));
    return userModel;
  }
}