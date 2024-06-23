class LogoutResponse {
  int? success;
  List<dynamic>? data;
  String? message;
  int? code;

  LogoutResponse({this.success, this.data, this.message, this.code});

  factory LogoutResponse.fromJson(Map<String, dynamic> json) {
    return LogoutResponse(
      success: json['success'] as int,
      data: json['data'] as List<dynamic>,
      message: json['message'] as String,
      code: json['code'] as int,
    );
  }
}
