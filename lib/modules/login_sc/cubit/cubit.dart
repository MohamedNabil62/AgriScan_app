import 'package:agriscan/models/login_model.dart';
import 'package:agriscan/modules/login_sc/cubit/state.dart';
import 'package:agriscan/shared/network/end_points.dart';
import 'package:agriscan/shared/network/remote/dio_helper.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';

class AgriScanLoginCubit extends Cubit<AgriScanLoginStates> {
  AgriScanLoginCubit() : super(AgriScanLoginInitialState());

  static AgriScanLoginCubit get(context) => BlocProvider.of(context);

  AgriScanLoginModel? loginModel;

  void userLogin({
    required String email,
    required String password,
  }) {
    emit(AgriScanLoginLoadingState());
    Diohelper.postData(
      url: LOGIN,
      data: {
        'email': email,
        'password': password,
      },
    ).then((value) {
      print(value?.data);
      loginModel = AgriScanLoginModel.fromJson(value?.data);
      emit(AgriScanLoginSuccessState(loginModel!));
    }).catchError((error) {
      if (error is DioError) {
        if (error.response?.statusCode == 422) {
          print('Validation Error: ${error.response?.data}');
          emit(AgriScanLoginErrorState('Validation Error: ${error.response?.data}'));
        } else {
          print('Dio Error: ${error.message}');
          emit(AgriScanLoginErrorState('Dio Error: ${error.message}'));
        }
      } else {
        print('Unexpected Error: ${error.toString()}');
        emit(AgriScanLoginErrorState('Unexpected Error: ${error.toString()}'));
      }
    });
  }

  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;

  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffix = isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(AgriScanchangePasswordVisibilityState());
  }
}
