import 'package:flutter/cupertino.dart';

class BoradingModel{
   int? id;
  String? image;
  String? name;
   String? Price;
  double? totalprice;
   int? num;
  BoradingModel({
    @required this.id,
    @required  this.image,
  @required  this.name,
    @required this.Price,
    @required this.totalprice,
    @required this.num,
  });
}
