class ModelUpComingMeetingUser {
  int? success;
  List<DataModelUpComingMeetingUser>? data;
  String? message;
  int? code;

  ModelUpComingMeetingUser({this.success, this.data, this.message, this.code});

  ModelUpComingMeetingUser.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <DataModelUpComingMeetingUser>[];
      json['data'].forEach((v) {
        data!.add(new DataModelUpComingMeetingUser.fromJson(v));
      });
    }
    message = json['message'];
    code = json['code'];
  }

}

class DataModelUpComingMeetingUser {
  int? id;
  String? startAt;
  String? url;
  Null? rating;
  String? status;

  DataModelUpComingMeetingUser({this.id, this.startAt, this.url, this.rating, this.status});

  DataModelUpComingMeetingUser.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    startAt = json['start_at'];
    url = json['url'];
    rating = json['rating'];
    status = json['status'];
  }

}
