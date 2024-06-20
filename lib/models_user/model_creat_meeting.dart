class ModelCreate {
  int? success;
  DataModelCreate? data;
  String? message;
  int? code;
  ModelCreate({this.success, this.data, this.message, this.code});
  ModelCreate.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? new DataModelCreate.fromJson(json['data']) : null;
    message = json['message'];
    code = json['code'];
  }


}

class DataModelCreate {
  String? paymentUrl;

  DataModelCreate({this.paymentUrl});

  DataModelCreate.fromJson(Map<String, dynamic> json) {
    paymentUrl = json['payment_url'];
  }

}
