import 'dart:async';
import 'dart:convert';

import 'package:arrivo_task/app/constant/api_constant.dart';
import 'package:arrivo_task/app/data/api/api_service.dart';
import 'package:arrivo_task/app/post/model/post_model.dart';
import 'package:dio/dio.dart';

class PostRepository {
  final ApiService apiService = ApiService();


  Future<List<PostModel>> fetchAllPosts() async {
    await Future.delayed(Duration(seconds: 1));
    Response response = await apiService.get(ApiConstant.post);
    List<PostModel> postModel = postModelFromJson(jsonEncode(response.data));
    return postModel;
  }

  Future<Response> deletePost(int postId) async {
    await Future.delayed(Duration(seconds: 1));
    Response response = await apiService.delete('${ApiConstant.post}/$postId');
    return response;
  }
}