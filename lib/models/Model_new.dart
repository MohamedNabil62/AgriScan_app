class ModelNewRqust {
  int? success;
  DataModelNewRqust? data;
  String? message;
  int? code;

  ModelNewRqust({this.success, this.data, this.message, this.code});

  ModelNewRqust.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? new DataModelNewRqust.fromJson(json['data']) : null;
    message = json['message'];
    code = json['code'];
  }
}

class DataModelNewRqust {
  String? amount;
  String? method;
  String? details;
  int? userId;
  String? updatedAt;
  String? createdAt;
  int? id;

  DataModelNewRqust(
      {this.amount,
        this.method,
        this.details,
        this.userId,
        this.updatedAt,
        this.createdAt,
        this.id});

  DataModelNewRqust.fromJson(Map<String, dynamic> json) {
    amount = json['amount'];
    method = json['method'];
    details = json['details'];
    userId = json['user_id'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }

}
