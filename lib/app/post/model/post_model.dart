// To parse this JSON data, do
//
//     final postModel = postModelFromJson(jsonString);

import 'dart:convert';

List<PostModel> postModelFromJson(String str) => List<PostModel>.from(json.decode(str).map((x) => PostModel.fromJson(x)));

String postModelToJson(List<PostModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PostModel {
  int? userId;
  int? id;
  String? title;
  String? body;
  bool selected;

  PostModel({
    this.userId,
    this.id,
    this.title,
    this.body,
    this.selected = false,
  });

  PostModel copyWith({bool? selected}) {
    return PostModel(
      userId: this.userId,
      id: this.id,
      title: this.title,
      body: this.body,
      selected: selected ?? this.selected,
    );
  }

  factory PostModel.fromJson(Map<String, dynamic> json) => PostModel(
    userId: json["userId"],
    id: json["id"],
    title: json["title"],
    body: json["body"],
  );

  Map<String, dynamic> toJson() => {
    "userId": userId,
    "id": id,
    "title": title,
    "body": body,
  };
}
