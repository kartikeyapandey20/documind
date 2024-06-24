class UserModel {
  int? id;
  String? email;
  String? name;
  String? contactNo;
  String? createdAt;

  UserModel({this.id, this.email, this.name, this.contactNo, this.createdAt});

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    name = json['name'];
    contactNo = json['contact_no'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['email'] = this.email;
    data['name'] = this.name;
    data['contact_no'] = this.contactNo;
    data['created_at'] = this.createdAt;
    return data;
  }
}
