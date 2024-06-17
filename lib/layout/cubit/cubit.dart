import 'package:agriscan/layout/cubit/state.dart';
import 'package:agriscan/models/UdataEngData.dart';
import 'package:agriscan/models/profile_model.dart';
import 'package:agriscan/shared/components/components.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import '../../modules/user_modules/agriscan_ai/agriscan_ai_screen.dart';
import '../../modules/user_modules/agriscan_crops/corps_screen.dart';
import '../../modules/user_modules/agriscan_engineer/agriscan_engineer_screen.dart';
import '../../modules/user_modules/agriscan_equipment/agriscan_farmequip.dart';
import '../../modules/user_modules/agriscan_setting/settings_screen.dart';
import '../../shared/components/constants.dart';
import '../../shared/network/end_points.dart';
import '../../shared/network/remote/dio_helper.dart';
class AgriScanCubit extends Cubit<AgriScanStates>{

  AgriScanCubit():super(AgriScanInitialState());
  static AgriScanCubit get(context) => BlocProvider.of(context);
  bool staut=false;
  IconData icon=Icons.edit;
  void ChangeBottemSheetState({
    @required bool? state,
    @required IconData? icons,
  }){
    icon=icons!;
    staut=state!;
    emit(AppChangeBottomSheetState());
  }
  int curent_index=0;
  List<Widget> bottomScreens=[
    AgriScanCropsScreen(),
    AgriScanFarmEquipScreen(),
    AgriScanAiScreen(),
    AgriScanEngineerScreen(),
    AgriScanSettingScreen()
  ];
  void changeBottom(int index)
  {
    curent_index=index;
    emit(AgriScanChangeBottomNavState());
  }
  File? profileImage;
  var picker = ImagePicker();
  Future<void> getProfileImage() async
  {
    var pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if(pickedFile !=null)
    {
      profileImage=File(pickedFile.path);
      emit(AgriscanGetProfileImageSuccessState());
    }else
    {
      print("No image selected");
      emit(AgriScanGetProfileImageErrorState());
    }
  }

  AgriScanDataUserModel? agriScanDataUserModel;
  String? tto;

  void getToken() {
    emit(AgriScanLoadingUserDataState());

    if (token != null) {
      tto = 'Bearer $token';

      Diohelper.get(
        url: PROFILE,
        token: tto!,
      ).then((value) {
        print(value.data);
        agriScanDataUserModel = AgriScanDataUserModel.fromJson(value.data);
        emit(AgriScanSuccessUserDataState());
      }).catchError((error) {
        if (error is DioError) {
          if (error.response != null) {
            print('Error Response: ${error.response?.data}');
            print('Error Status Code: ${error.response?.statusCode}');
          } else {
            print('Error Message: ${error.message}');
          }
        } else {
          print('Unexpected Error: ${error.toString()}');
        }
        emit(AgriScanErrorUserDataState(error.toString()));
      });
    } else {
      print('Token is null');
      emit(AgriScanErrorUserDataState('Token is null'));
    }
  }
 ModelUpdataEng? modelUpdataEng;
void upDateEngDat({
  required String name,
  required String email,
})
{
  emit(AgriScanLoadingUpdateUserDataState());
  if (token != null) {
    tto = 'Bearer $token';
  Diohelper.postData(
    url: UPDATEENGDATA,
    token:tto ,
    data: {
      'name':name,
      'email': email,
    },
  ).then((value) {
    modelUpdataEng=ModelUpdataEng.fromJson(value?.data);
    getToken();
    emit(AgriScanSuccessUpdateUserDataState());
  }).catchError((error) {
    if (error is DioError) {
      if (error.response?.statusCode == 422) {
        showToast(text:error.response?.data.toString() as String , state: ToastState.ERROR);
        print('Validation Error: ${error.response?.data}');
        emit(AgriScanErrorUpdateUserDataState('Validation Error: ${error.response?.data}'));
      } else {
        print('Dio Error: ${error.message}');
        emit(AgriScanErrorUpdateUserDataState('Dio Error: ${error.message}'));
      }
    } else {
      print('Unexpected Error: ${error.toString()}');
      emit(AgriScanErrorUpdateUserDataState('Unexpected Error: ${error.toString()}'));
    }
  });
}
}}