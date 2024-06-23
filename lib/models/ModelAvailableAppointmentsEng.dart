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

  factory ModelAvailableAppointmentsEng.fromJson(Map<String, dynamic> json) {
    Map<String, List<Appointment>> parsedData = {};
    if (json['data'] is Map) {
      json['data'].forEach((date, appointments) {
        parsedData[date] = (appointments as List)
            .map((e) => Appointment.fromJson(e))
            .toList();
      });
    }

    return ModelAvailableAppointmentsEng(
      success: json['success'],
      data: parsedData,
      message: json['message'],
      code: json['code'],
    );
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
