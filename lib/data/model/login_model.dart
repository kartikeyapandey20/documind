class LoginModel {
  String? accessToken;
  String? tokenType;
  int? userId;

  LoginModel({this.accessToken, this.tokenType, this.userId});

  LoginModel.fromJson(Map<String, dynamic> json) {
    accessToken = json['access_token'];
    tokenType = json['token_type'];
    userId = json['user_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['access_token'] = this.accessToken;
    data['token_type'] = this.tokenType;
    data['user_id'] = this.userId;
    return data;
  }

}
