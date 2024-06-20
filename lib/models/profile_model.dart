class AgriScanDataUserModel {
  int? success;
  DataAgriScanDataUserModel? data;
  String? message;
  int? code;

  AgriScanDataUserModel({this.success, this.data, this.message, this.code});

  AgriScanDataUserModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? new DataAgriScanDataUserModel.fromJson(json['data']) : null;
    message = json['message'];
    code = json['code'];
  }

}

class DataAgriScanDataUserModel {
  int? id;
  String? name;
  String? email;
  String? role;
  int? balance;

  DataAgriScanDataUserModel({this.id, this.name, this.email, this.role, this.balance});

  DataAgriScanDataUserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    role = json['role'];
    balance = json['balance'];
  }

}
