class UserSignInResponseData {

  String message;
  int status;
  int httpcode;
  Detail mDetail;

  UserSignInResponseData({
    this.message,
    this.status,
    this.httpcode,
    this.mDetail
  });


  factory UserSignInResponseData.fromJson(Map<String, dynamic> json) =>
      new UserSignInResponseData(
        message: json["message"],
        status: json["status"],
        httpcode: json["httpcode"],
        mDetail: json['detail'] != null ? new Detail.fromJson(json['detail']) : null
      );

}

class Detail {
  String userName;
  String imageUrl;
  String userEmail;
  String phoneNum;
  int id;
  String token;
  String gender;
  String last_name;

  Detail({
    this.userName, this.imageUrl, this.userEmail, this.phoneNum, this.id, this.token, this.gender, this.last_name
  });

  factory Detail.fromJson(Map<String, dynamic> json) =>
      new Detail(
          userName: json["userName"],
          imageUrl: json["imageUrl"],
          userEmail: json["userEmail"],
          phoneNum: json["phoneNum"],
          id: json["id"],
          token: json["token"],
          gender: json["gender"],
          last_name: json["last_name"]
      );
}