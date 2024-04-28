
import 'package:agriscan/models/register_model.dart';
import 'package:agriscan/modules/register_sc/cubit/state.dart';
import 'package:agriscan/shared/network/end_points.dart';
import 'package:agriscan/shared/network/remote/dio_helper.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class AgriScanRegisterCubit extends Cubit<AgriScanRegisterStates>
{
  AgriScanRegisterCubit():super(AgriScanRegisterInitialState());

static AgriScanRegisterCubit get(context) => BlocProvider.of(context);
  ShopRegistrMode? RegistrModel;
  void userRegister({
    required String name,
    required String email,
    required String password,
    required String phone,
  }
      ){
    emit(AgriScanRegisterLoadingState());
    Diohelper.postData(
        url: REGISTER,
        data: {
          'name':name,
          'email':email,
          'password':password,
          'phone':phone,
        },
    ).then((value){
     print(value?.data);
     RegistrModel=ShopRegistrMode.fromJson(value?.data);
   print(RegistrModel?.status);
     print(RegistrModel?.data?.email);
      emit(AgriScanRegisterSuccessState(RegistrModel!));
    }).catchError((error){
      print(error.toString());
      emit(AgriScanRegisterErrorState(error.toString()));
    });
  }

  IconData suffix=Icons.visibility_outlined;
  bool isPassword=true;
  void changePasswordVisibility(){
    isPassword =! isPassword;
    suffix=isPassword?Icons.visibility_outlined:Icons.visibility_off_outlined;
    emit(AgriScanRegisterchangePasswordVisibilityState());
  }
}