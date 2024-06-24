import 'dart:convert';

class CategoryModel {
  int? id;
  String? categoryName;
  String? createdAt;

  CategoryModel({this.id, this.categoryName, this.createdAt});

  CategoryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryName = json['category_name'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['category_name'] = this.categoryName;
    data['created_at'] = this.createdAt;
    return data;
  }
  static List<CategoryModel> listFromJson(List<dynamic> jsonList) {
    return jsonList.map((item) => CategoryModel.fromJson(item)).toList();
  }
}
