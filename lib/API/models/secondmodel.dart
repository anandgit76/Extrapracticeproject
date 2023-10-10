// To parse this JSON data, do
//
//     final userTest = userTestFromJson(jsonString);

import 'dart:convert';

List<UserTest> userTestFromJson(String str) => List<UserTest>.from(json.decode(str).map((x) => UserTest.fromJson(x)));

String userTestToJson(List<UserTest> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UserTest {
  int userId;
  int id;
  String title;
  String body;

  UserTest({
    required this.userId,
    required this.id,
    required this.title,
    required this.body,
  });

  factory UserTest.fromJson(Map<String, dynamic> json) => UserTest(
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
