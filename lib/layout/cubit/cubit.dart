import 'package:agriscan/layout/cubit/state.dart';
import 'package:agriscan/models/categories_model.dart';
import 'package:agriscan/models/favorites_modelGET.dart';
import 'package:agriscan/models/home_model.dart';
import 'package:agriscan/models/profile_model.dart';
import 'package:agriscan/modules/agriscan_ai/agriscan_ai_screen.dart';
import 'package:agriscan/modules/agriscan_crops/corps_screen.dart';
import 'package:agriscan/modules/agriscan_engineer/agriscan_engineer_screen.dart';
import 'package:agriscan/modules/agriscan_equipment/agriscan_farmequip.dart';
import 'package:agriscan/modules/agriscan_setting/settings_screen.dart';
import 'package:agriscan/shared/components/constants.dart';
import 'package:agriscan/shared/network/end_points.dart';
import 'package:agriscan/shared/network/remote/dio_helper.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
class AgriScanCubit extends Cubit<AgriScanStates>{

  AgriScanCubit():super(AgriScanInitialState());
  static AgriScanCubit get(context) => BlocProvider.of(context);

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

 
}