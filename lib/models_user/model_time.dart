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

  ModelAvailableAppointmentsUser.fromJson(Map<String, dynamic> json)
      : data = {}, // Initialize data as an empty map by default
        success = json['success'],
        message = json['message'],
        code = json['code'] {
    if (json['data'] != null) {
      json['data'].forEach((date, appointments) {
        data[date] = (appointments as List)
            .map((e) => AppointmentUser.fromJson(e))
            .toList();
      });
    }
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
