class ModelUpComeingMeeting {
  int? success;
  List<DataModelUpComeingMeeting>? data;
  String? message;
  int? code;

  ModelUpComeingMeeting({this.success, this.data, this.message, this.code});

  ModelUpComeingMeeting.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <DataModelUpComeingMeeting>[];
      json['data'].forEach((v) {
        data!.add(new DataModelUpComeingMeeting.fromJson(v));
      });
    }
    message = json['message'];
    code = json['code'];
  }

}

class DataModelUpComeingMeeting {
  int? id;
  String? startAt;
  String? url;
  String? rating;
  String? status;
  UserModelUpComeingMeeting? user;

  DataModelUpComeingMeeting({this.id, this.startAt, this.url, this.rating, this.status, this.user});

  DataModelUpComeingMeeting.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    startAt = json['start_at'];
    url = json['url'];
    rating = json['rating'];
    status = json['status'];
    user = json['user'] != null ? new UserModelUpComeingMeeting.fromJson(json['user']) : null;
  }

}

class UserModelUpComeingMeeting {
  int? id;
  String? name;
  String? email;
  String? role;

  UserModelUpComeingMeeting({this.id, this.name, this.email, this.role});

  UserModelUpComeingMeeting.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    role = json['role'];
  }

}