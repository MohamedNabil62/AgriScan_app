class ModelListEng {
  int? success;
  List<DataModelListEng>? data;
  String? message;
  int? code;

  ModelListEng({this.success, this.data, this.message, this.code});

  ModelListEng.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <DataModelListEng>[];
      json['data'].forEach((v) {
        data!.add(new DataModelListEng.fromJson(v));
      });
    }
    message = json['message'];
    code = json['code'];
  }


}

class DataModelListEng {
  int? id;
  String? name;
  String? email;
  RatesModelListEng? rates;

  DataModelListEng({this.id, this.name, this.email, this.rates});

  DataModelListEng.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    rates = json['rates'] != null ? new RatesModelListEng.fromJson(json['rates']) : null;
  }


}

class RatesModelListEng {
  int? meetingRate;
  int? overRating;

  RatesModelListEng({this.meetingRate, this.overRating});

  RatesModelListEng.fromJson(Map<String, dynamic> json) {
    meetingRate = json['meeting_rate'];
    overRating = json['over_rating'];
  }

}
