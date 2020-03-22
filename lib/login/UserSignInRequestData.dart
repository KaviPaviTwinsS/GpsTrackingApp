import 'dart:convert';

import 'package:flutterlocationupdate/login/UserSignInResponseData.dart';

UserSignInResponseData postFromJson(String str) {
  final jsonData = json.decode(str);
  return UserSignInResponseData.fromJson(jsonData);
}

String postToJson(UserSignInRequestData data) {
  final dyn = data.toJson();
  print('POST to json ${json.encode(dyn)}');
  return json.encode(dyn);
}

class UserSignInRequestData {
  String deviceId;
  String deviceToken;
  int deviceType;
  String language;
  String password;
  String email;

  UserSignInRequestData({
    this.deviceId,
    this.deviceToken,
    this.deviceType,
    this.language,
    this.password,
    this.email,
  });


  Map<String, dynamic> toJson() => {
    "email": email,
    "password": password,
    "deviceId":deviceId,
    "deviceToken" :deviceToken,
    "deviceType":deviceType,
    "language" :language,
  };
}