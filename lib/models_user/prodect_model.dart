class ModelProdect {
  int? success;
  List<DataModelProdect>? data;
  String? message;
  int? code;
  ModelProdect({this.success, this.data, this.message, this.code});
  ModelProdect.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <DataModelProdect>[];
      json['data'].forEach((v) {
        data!.add(new DataModelProdect.fromJson(v));
      });
    }
    message = json['message'];
    code = json['code'];
  }
}
class DataModelProdect {
  int? id;
  String? name;
  String? description;
  int? price;
  String? isActive;
  String? cover;

  DataModelProdect(
      {this.id,
        this.name,
        this.description,
        this.price,
        this.isActive,
        this.cover});

  DataModelProdect.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    price = json['price'];
    isActive = json['is_active'];
    cover = json['cover'];
  }
}
