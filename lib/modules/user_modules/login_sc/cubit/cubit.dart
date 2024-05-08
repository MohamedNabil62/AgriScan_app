
import 'package:agriscan/models/login_model.dart';
import 'package:agriscan/modules/login_sc/cubit/state.dart';
import 'package:agriscan/shared/network/end_points.dart';
import 'package:agriscan/shared/network/remote/dio_helper.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class AgriScanLoginCubit extends Cubit<AgriScanLoginStates>
{
  AgriScanLoginCubit():super(AgriScanLoginInitialState());

static AgriScanLoginCubit get(context) => BlocProvider.of(context);
  ShopLoginModel? LoginModel;
  void userLogin({
    required String email,
    required String password,
  }
      ){
    emit(AgriScanLoginLoadingState());
    Diohelper.postData(
        url: LOGIN,
        data: {
          'email':email,
          'password':password
        },
    ).then((value){
     print(value?.data);
     LoginModel=ShopLoginModel.formJson(value?.data);
   print(LoginModel?.status);
     print(LoginModel?.data.email);
      emit(AgriScanLoginSuccessState(LoginModel!));
    }).catchError((error){
      print(error.toString());
      emit(AgriScanLoginErrorState(error.toString()));
    });
  }

  IconData suffix=Icons.visibility_outlined;
  bool isPassword=true;
  void changePasswordVisibility(){
    isPassword =! isPassword;
    suffix=isPassword?Icons.visibility_outlined:Icons.visibility_off_outlined;
    emit(AgriScanchangePasswordVisibilityState());
  }
}