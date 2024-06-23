class ModelAvailableAppointmentsUser {
  int? success;
  Map<String, List<AppointmentUser>> data; // Use a map to store appointments by date
  String? message;
  int? code;

  ModelAvailableAppointmentsUser({
    this.success,
    required this.data, // Ensure data is required
    this.message,
    this.code,
  });

  factory ModelAvailableAppointmentsUser.fromJson(Map<String, dynamic> json) {
    // Check if 'data' is a List or Map and initialize accordingly
    Map<String, List<AppointmentUser>> parsedData = {};
    if (json['data'] is Map) {
      json['data'].forEach((date, appointments) {
        parsedData[date] = (appointments as List)
            .map((e) => AppointmentUser.fromJson(e))
            .toList();
      });
    }

    return ModelAvailableAppointmentsUser(
      success: json['success'],
      data: parsedData,
      message: json['message'],
      code: json['code'],
    );
  }
}

class AppointmentUser {
  int id;
  String time;

  AppointmentUser({
    required this.id,
    required this.time,
  });

  factory AppointmentUser.fromJson(Map<String, dynamic> json) {
    return AppointmentUser(
      id: json['id'],
      time: json['time'],
    );
  }
}
