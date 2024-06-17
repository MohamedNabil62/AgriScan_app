class AgriScanRegistrModel {
  int? success;
  DataAgriScanRegistrModel? data;
  String? message;
  int? code;

  AgriScanRegistrModel({this.success, this.data, this.message, this.code});

  AgriScanRegistrModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? new DataAgriScanRegistrModel.fromJson(json['data']) : null;
    message = json['message'] !=null ?json['message']:"An account has been created";
    code = json['code'];
  }
}

class DataAgriScanRegistrModel {
  String? token;
  UserAgriScanRegistrModel? user;

  DataAgriScanRegistrModel({this.token, this.user});

  DataAgriScanRegistrModel.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    user = json['user'] != null ? new UserAgriScanRegistrModel.fromJson(json['user']) : null;
  }
}

class UserAgriScanRegistrModel {
  int? id;
  String? name;
  String? email;
  String? role;

  UserAgriScanRegistrModel({this.id, this.name, this.email, this.role});

  UserAgriScanRegistrModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    role = json['role'];
  }
}