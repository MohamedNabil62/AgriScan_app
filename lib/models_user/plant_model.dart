class ModelPlant {
  int? success;
  List<DataModelPlant>? data;
  String? message;
  int? code;

  ModelPlant({this.success, this.data, this.message, this.code});

  ModelPlant.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <DataModelPlant>[];
      json['data'].forEach((v) {
        data!.add(new DataModelPlant.fromJson(v));
      });
    }
    message = json['message'];
    code = json['code'];
  }
}

class DataModelPlant {
  int? id;
  String? name;
  String? description;
  String? cover;

  DataModelPlant({this.id, this.name, this.description, this.cover});

  DataModelPlant.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    cover = json['cover'];
  }
}
