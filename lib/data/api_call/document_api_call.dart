import 'dart:convert';

import 'package:documind/data/model/category_model.dart';
import 'package:documind/data/model/extract_text_model.dart';
import 'package:documind/data/model/project_model.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

import '../../constant/config_constant.dart';

class DocumentApiCall{
  Future<List<CategoryModel>> getCategory() async {
    String apiUrl = "${Contant.baseUrl}category";
    print(apiUrl);
    try {
      var response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        // Successful login
        var responseData = json.decode(response.body);
        print(responseData);
        // Handle your response here, such as storing user data in SharedPreferences or Redux store
        return CategoryModel.listFromJson(responseData);
      } else {
        // Handle other status codes here, such as showing error messages
        var responseData = json.decode(response.body);
        print('Error: ${response.body}');
        print('Error: ${response.reasonPhrase}');
        return CategoryModel.listFromJson(responseData);
      }
    } catch (e) {
      // Handle other errors such as network errors
      throw e;
    }
  }
  Future<List<ProjectModel>> getProject(int categoryId) async {
    String apiUrl = "${Contant.baseUrl}project/category_wise";
    var body = jsonEncode(
        {
          "category_id" : categoryId,
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
        return ProjectModel.listFromJson(responseData);
      }
      if(response.statusCode == 500)
      {
        Fluttertoast.showToast(msg: "Something went wrong");
        throw "Something went wrong";
      }
      else {
        // Handle other status codes here, such as showing error messages
        var responseData = json.decode(response.body);
        print('Error: ${response.body}');
        print('Error: ${response.reasonPhrase}');
        return ProjectModel.listFromJson( responseData);
      }
    } catch (e) {
      // Handle other errors such as network errors
      throw e;
    }
  }
  Future<ExtractTextModel> textForLLM(String fileName) async {
    String apiUrl = "${Contant.baseUrl}project/extract_text_from_file";
    var body = jsonEncode(
        {
          "file_name" : "$fileName"
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
        return ExtractTextModel.fromJson(responseData);
      }
      if(response.statusCode == 500)
      {
        Fluttertoast.showToast(msg: "Something went wrong");
        throw "Something went wrong";
      }
      else {
        // Handle other status codes here, such as showing error messages
        var responseData = json.decode(response.body);
        print('Error: ${response.body}');
        print('Error: ${response.reasonPhrase}');
        return ExtractTextModel.fromJson(responseData);
      }
    } catch (e) {
      // Handle other errors such as network errors
      throw e;
    }
  }

}