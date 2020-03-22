import 'dart:convert';
import 'dart:io';

import 'package:flutterlocationupdate/CoreClient.dart';
import 'package:flutterlocationupdate/login/UserSignInRequestData.dart';
import 'package:flutterlocationupdate/login/UserSignInResponseData.dart';
import 'package:http/http.dart' as http;
Future<UserSignInResponseData> createPost(UserSignInRequestData userSignInRequestData) async{
  final response = await http.post('$url',
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json'
      },
      body: postToJson(userSignInRequestData)
  );
  return postFromJson(response.body);
}


//get method
Future<UserSignInResponseData> getPost() async{
  final response = await http.get('$url/1');
  return postFromJson(response.body);
}


/*

Future<UserSignInResponseData> createPost({Map body}) async {
  return http.post(url, body: body).then((http.Response response) {
    final int statusCode = response.statusCode;
    if (statusCode < 200 || statusCode > 400 || json == null) {
      throw new Exception("Error while fetching data");
    }
    return UserSignInResponseData.fromJson(json.decode(response.body));
  });
}*/
