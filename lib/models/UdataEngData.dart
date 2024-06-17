class ModelUpdataEng {
  int? success;
  DataModelUpdataEng? data;
  String? message;
  int? code;

  ModelUpdataEng({this.success, this.data, this.message, this.code});

  ModelUpdataEng.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? new DataModelUpdataEng.fromJson(json['data']) : null;
    message = json['message'];
    code = json['code'];
  }


}

class DataModelUpdataEng {
  UserModelUpdataEng? user;

  DataModelUpdataEng({this.user});

  DataModelUpdataEng.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? new UserModelUpdataEng.fromJson(json['user']) : null;
  }

}

class UserModelUpdataEng {
  int? id;
  String? name;
  String? email;
  String? role;
  UserModelUpdataEng({this.id, this.name, this.email, this.role});
  UserModelUpdataEng.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    role = json['role'];
  }
}
