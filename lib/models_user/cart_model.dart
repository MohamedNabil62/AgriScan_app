class AgriScanCartModel {
  int? success;
  CartData? data;
  String? message;
  int? code;
  AgriScanCartModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? new CartData.fromJson(json['data']) : null;
    message = json['message'];
    code = json['code'];
  }
}

class CartData {
  String? paymentUrl;

  CartData({this.paymentUrl});

  CartData.fromJson(Map<String, dynamic> json) {
    paymentUrl = json['payment_url'];
  }
}