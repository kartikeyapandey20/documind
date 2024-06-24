import 'dart:convert';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

import '../../constant/config_constant.dart';
import '../model/login_model.dart';
import '../model/signup_model.dart';
import '../model/user_model.dart';

class UserApiCall{

  Future<LoginModel> loginUser(String email, String password) async {
    String apiUrl = Contant.baseUrl + Contant.login;

    try {
      var request = http.MultipartRequest('POST', Uri.parse(apiUrl));
      request.fields['username'] = email;
      request.fields['password'] = password;

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        // Successful login
        var responseData = json.decode(response.body);
        // Handle your response here, such as storing user data in SharedPreferences or Redux store
        return LoginModel.fromJson(responseData);
      } else {
        // Handle other status codes here, such as showing error messages
        var responseData = json.decode(response.body);
        print('Error: ${response.reasonPhrase}');
        return LoginModel.fromJson(responseData);
      }
    } catch (e) {
      // Handle other errors such as network errors
      throw e;
    }
  }
  Future<UserModel> getUser(int userId) async {
    String apiUrl = "${Contant.baseUserUrl}$userId";
    print(apiUrl);
    try {
      var response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        // Successful login
        var responseData = json.decode(response.body);
        print(responseData);
        // Handle your response here, such as storing user data in SharedPreferences or Redux store
        return UserModel.fromJson(responseData);
      } else {
        // Handle other status codes here, such as showing error messages
        var responseData = json.decode(response.body);
        print('Error: ${response.body}');
        print('Error: ${response.reasonPhrase}');
        return UserModel.fromJson(responseData);
      }
    } catch (e) {
      // Handle other errors such as network errors
      throw e;
    }
  }
  Future<SignUpModel> signUpUser(String name , String email , String mobileNo , String password) async {
    String apiUrl = Contant.baseUserUrl;
    var body = jsonEncode(
        {
          "email" : email,
          "name" : name,
          "contact_no" : mobileNo,
          "password" : password
        }
    );
    print(apiUrl);
    try {
      var response = await http.post(Uri.parse(apiUrl),body:body,headers: {'Content-Type': 'application/json'},);

      if (response.statusCode == 201) {
        // Successful login
        var responseData = json.decode(response.body);
        print(responseData);
        // Handle your response here, such as storing user data in SharedPreferences or Redux store
        return SignUpModel.fromJson(responseData);
      }
      if(response.statusCode == 500)
        {
          Fluttertoast.showToast(msg: "User already exists");
          throw "User already exists";
        }
      else {
        // Handle other status codes here, such as showing error messages
        var responseData = json.decode(response.body);
        print('Error: ${response.body}');
        print('Error: ${response.reasonPhrase}');
        return SignUpModel.fromJson(responseData);
      }
    } catch (e) {
      // Handle other errors such as network errors
      throw e;
    }
  }
}