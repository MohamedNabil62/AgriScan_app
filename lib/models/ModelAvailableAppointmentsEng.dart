class ModelAvailableAppointmentsEng {
  int? success;
  Map<String, List<Appointment>> data; // Use a map to store appointments by date
  String? message;
  int? code;

  ModelAvailableAppointmentsEng({
    this.success,
    required this.data, // Ensure data is required
    this.message,
    this.code,
  });

  ModelAvailableAppointmentsEng.fromJson(Map<String, dynamic> json)
      : data = {}, // Initialize data as an empty map by default
        success = json['success'],
        message = json['message'],
        code = json['code'] {
    if (json['data'] != null) {
      json['data'].forEach((date, appointments) {
        data[date] = (appointments as List)
            .map((e) => Appointment.fromJson(e))
            .toList();
      });
    }
  }
}

class Appointment {
  int id;
  String time;

  Appointment({
    required this.id,
    required this.time,
  });

  factory Appointment.fromJson(Map<String, dynamic> json) {
    return Appointment(
      id: json['id'],
      time: json['time'],
    );
  }
}
