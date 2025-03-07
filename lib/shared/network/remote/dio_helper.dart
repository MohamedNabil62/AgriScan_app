
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

class Diohelper
{
  static Dio? dio;

  static init()
  {
    dio=Dio(
        BaseOptions(
            baseUrl:"https://acms-testing.smaster.live/api", //shop app
            receiveDataWhenStatusError:true ,
            headers: {
              'Accept':'application/json'
            }
        )
    );
  }
  static Future get({
    required String url,
    Map<String,dynamic>? query,
    String leng='en',
    String? token,
  }) async
  {
    dio?.options.headers=
    {
      'Content-Type':'application/json',
      'lang':leng,
      'Authorization':token
    };
    return await dio?.get(url,queryParameters: query);
  }

  static Future<Response?> postData(
      {
        required String url,
        required Map<String,dynamic> data,
        Map<String,dynamic>? query,
        String leng='en',
        String? token,
      }
      ) async{
    dio?.options.headers=
    {
      'Accept':'application/json',
      'Authorization':token
    };
    FormData formData = FormData.fromMap(data);
    return  dio?.post(url,queryParameters: query,data: formData,);
  }

  static Future<Response?> putData(
      {
        required String url,
        required Map<String,dynamic> data,
        Map<String,dynamic>? query,
        String leng='en',
        String? token,
      }
      ) async{
    dio?.options.headers=
    {
      'Content-Type':'application/json',
      'lang':leng,
      'Authorization':token
    };
    return  dio?.put(
      url,queryParameters: query,data: data,);
  }
  static Future<Response?> postDataa(
      {
        required String url,
        Map<String,dynamic>? query,
        String leng='en',
        String? token,
      }
      ) async{
    dio?.options.headers=
    {
      'Accept':'application/json',
      'Authorization':token
    };
    return  dio?.post(url,queryParameters: query,);
  }
}