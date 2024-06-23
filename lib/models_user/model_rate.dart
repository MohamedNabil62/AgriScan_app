class ModelRatingUser {
  int? success;
  DataModelRatingUser? data;
  String? message;
  int? code;

  ModelRatingUser({this.success, this.data, this.message, this.code});

  ModelRatingUser.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? new DataModelRatingUser.fromJson(json['data']) : null;
    message = json['message'];
    code = json['code'];
  }
}

class DataModelRatingUser {
  int? id;
  String? startAt;
  String? url;
  String? rating;
  String? status;
  UserModelRatingUser? user;
  EngModelRatingUser? eng;
  DataModelRatingUser(
      {this.id,
        this.startAt,
        this.url,
        this.rating,
        this.status,
        this.user,
        this.eng});

  DataModelRatingUser.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    startAt = json['start_at'];
    url = json['url'];
    rating = json['rating'];
    status = json['status'];
    user = json['user'] != null ? new UserModelRatingUser.fromJson(json['user']) : null;
    eng = json['eng'] != null ? new EngModelRatingUser.fromJson(json['eng']) : null;
  }
}

class UserModelRatingUser {
  int? id;
  String? name;
  String? email;
  String? role;
  int? balance;

  UserModelRatingUser({this.id, this.name, this.email, this.role, this.balance});

  UserModelRatingUser.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    role = json['role'];
    balance = json['balance'];
  }
}

class EngModelRatingUser {
  int? id;
  String? name;
  String? email;
  String? role;
  int? balance;
  RatesModelRatingUser? rates;

  EngModelRatingUser({this.id, this.name, this.email, this.role, this.balance, this.rates});

  EngModelRatingUser.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    role = json['role'];
    balance = json['balance'];
    rates = json['rates'] != null ? new RatesModelRatingUser.fromJson(json['rates']) : null;
  }

}

class RatesModelRatingUser {
  int? meetingRate;
  int? overallRating;

  RatesModelRatingUser({this.meetingRate, this.overallRating});

  RatesModelRatingUser.fromJson(Map<String, dynamic> json) {
    meetingRate = json['meeting_rate'];
    overallRating = json['overall_rating'];
  }

}
