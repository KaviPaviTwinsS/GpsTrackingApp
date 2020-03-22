import 'dart:convert';

import 'package:flutterlocationupdate/login/UserSignInResponseData.dart';

UserSignInResponseData postFromJson(String str) {
  final jsonData = json.decode(str);
  return UserSignInResponseData.fromJson(jsonData);
}

String postToJson(UserSignInRequestData data) {
  final dyn = data.toJson();
  return json.encode(dyn);
}

class UserSignInRequestData {
  String email;
  String password;

  UserSignInRequestData({
    this.email,
    this.password,
  });


  Map<String, dynamic> toJson() => {
    "userEmail": email,
    "userPassword": password,
  };
}