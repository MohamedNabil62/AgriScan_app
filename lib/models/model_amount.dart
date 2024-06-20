class ModelAmount {
  int? success;
  List<DataModelAmount>? data;
  String? message;
  int? code;

  ModelAmount({this.success, this.data, this.message, this.code});

  ModelAmount.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <DataModelAmount>[];
      json['data'].forEach((v) {
        data!.add(new DataModelAmount.fromJson(v));
      });
    }
    message = json['message'];
    code = json['code'];
  }

}

class DataModelAmount {
  int? id;
  int? amount;
  String? method;
  String? details;
  String? status;
  String? createdAt;
  String? lastUpdate;

  DataModelAmount(
      {this.id,
        this.amount,
        this.method,
        this.details,
        this.status,
        this.createdAt,
        this.lastUpdate});

  DataModelAmount.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    amount = json['amount'];
    method = json['method'];
    details = json['details'];
    status = json['status'];
    createdAt = json['created_at'];
    lastUpdate = json['last_update'];
  }


}
