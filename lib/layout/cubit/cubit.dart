import 'package:agriscan/layout/cubit/state.dart';
import 'package:agriscan/models/categories_model.dart';
import 'package:agriscan/models/favorites_modelGET.dart';
import 'package:agriscan/models/home_model.dart';
import 'package:agriscan/models/profile_model.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import '../../modules/user_modules/agriscan_ai/agriscan_ai_screen.dart';
import '../../modules/user_modules/agriscan_crops/corps_screen.dart';
import '../../modules/user_modules/agriscan_engineer/agriscan_engineer_screen.dart';
import '../../modules/user_modules/agriscan_equipment/agriscan_farmequip.dart';
import '../../modules/user_modules/agriscan_setting/settings_screen.dart';
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