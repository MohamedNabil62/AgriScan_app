class ModelSetTime {
  int? success;
  DataSetTime? data;
  String? message;
  int? code;

  ModelSetTime({this.success, this.data, this.message, this.code});

  ModelSetTime.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? new DataSetTime.fromJson(json['data']) : null;
    message = json['message'];
    code = json['code'];
  }

}

class DataSetTime {
  int? id;
  String? startAt;

  DataSetTime({this.id, this.startAt});

  DataSetTime.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    startAt = json['start_at'];
  }

}