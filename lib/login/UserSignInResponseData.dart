class UserSignInResponseData {

  int message;
  int status;
  String title;
  String body;

  UserSignInResponseData({
    this.message,
    this.status,
    this.title
  });

  factory UserSignInResponseData.fromJson(Map<String, dynamic> json) => new UserSignInResponseData(
    message: json["message"],
    status: json["status"],
    title: json["title"]
  );


}