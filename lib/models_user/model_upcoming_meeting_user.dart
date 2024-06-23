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
  int? rating;
  String? status;
  EngModelUpComingMeetingUser? eng;

  DataModelUpComingMeetingUser({this.id, this.startAt, this.url, this.rating, this.status, this.eng});

  DataModelUpComingMeetingUser.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    startAt = json['start_at'];
    url = json['url'];
    rating = json['rating'];
    status = json['status'];
    eng = json['eng'] != null ? new EngModelUpComingMeetingUser.fromJson(json['eng']) : null;
  }

}

class EngModelUpComingMeetingUser {
  int? id;
  String? name;
  String? email;
  String? role;
  int? balance;
  RatesModelUpComingMeetingUser? rates;

  EngModelUpComingMeetingUser({this.id, this.name, this.email, this.role, this.balance, this.rates});

  EngModelUpComingMeetingUser.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    role = json['role'];
    balance = json['balance'];
    rates = json['rates'] != null ? new RatesModelUpComingMeetingUser.fromJson(json['rates']) : null;
  }

}

class RatesModelUpComingMeetingUser {
  int? meetingRate;
  int? overallRating;

  RatesModelUpComingMeetingUser({this.meetingRate, this.overallRating});

  RatesModelUpComingMeetingUser.fromJson(Map<String, dynamic> json) {
    meetingRate = json['meeting_rate'];
    overallRating = json['overall_rating'];
  }

}
