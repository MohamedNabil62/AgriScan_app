class AgriScanLoginModel {
  int? success;
  DataAgriScanLoginModel? data;
  String? message;
  int? code;

  AgriScanLoginModel({this.success, this.data, this.message, this.code});

  AgriScanLoginModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? new DataAgriScanLoginModel.fromJson(json['data']) : null;
    message = json['message'];
    code = json['code'];
  }
}

class DataAgriScanLoginModel {
  String? token;
  UserAgriScanLoginModel? user;

  DataAgriScanLoginModel({this.token, this.user});

  DataAgriScanLoginModel.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    user = json['user'] != null ? new UserAgriScanLoginModel.fromJson(json['user']) : null;
  }

}

class UserAgriScanLoginModel {
  int? id;
  String? name;
  String? email;
  String? role;

  UserAgriScanLoginModel({this.id, this.name, this.email, this.role});

  UserAgriScanLoginModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    role = json['role'];
  }

}