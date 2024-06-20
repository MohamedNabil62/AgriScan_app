import 'package:agriscan/layout/cubit/state.dart';
import 'package:agriscan/layout/cubit_eng/cubit.dart';
import 'package:agriscan/models/ModelAvailableAppointmentsEng.dart';
import 'package:agriscan/models/UdataEngData.dart';
import 'package:agriscan/models/profile_model.dart';
import 'package:agriscan/models_user/List_eng.dart';
import 'package:agriscan/models_user/model_creat_meeting.dart';
import 'package:agriscan/models_user/model_upcoming_meeting_user.dart';
import 'package:agriscan/models_user/order_model.dart';
import 'package:agriscan/models_user/plant_model.dart';
import 'package:agriscan/models_user/prodect_model.dart';
import 'package:agriscan/shared/components/components.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import '../../models_user/model_time.dart';
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
}

ModelListEng? modelListEng;
void getListEng()
{
  emit(AgriScanStateLoadingListEng());

  if (token != null) {
    String tto = 'Bearer $token'; // Ensure tto is initialized correctly

    Diohelper.get(
      url:  LISTENG,
      token: tto,
    ).then((value) {
      modelListEng=ModelListEng.fromJson(value.data);
      emit(AgriScanStateSuccessListEng());
    }).catchError((error) {
      if (error is DioError) {
        if (error.response != null) {
          print('Error Response: ${error.response!.data}');
          print('Error Status Code: ${error.response!.statusCode}');
        } else {
          print('Error Message: ${error.message}');
        }
      } else {
        print('Unexpected Error: ${error.toString()}');
      }
      emit(AgriScanStateErrorListEng(error.toString()));
    });
  } else {
    print('Token is null');
    emit(AgriScanStateErrorListEng('Token is null'));
  }
}

ModelAvailableAppointmentsUser? modelAvailableAppointmentsUser;
void timeEng(int id)
{
  emit(AgriScanStateLoadingTimeUser());

  if (token != null) {
    String tto = 'Bearer $token'; // Ensure tto is initialized correctly

    Diohelper.get(
      url:  '/users/engs/${id}/available-times',
      token: tto,
    ).then((value) {
      modelAvailableAppointmentsUser=ModelAvailableAppointmentsUser.fromJson(value.data);
      if (modelAvailableAppointmentsUser!.data.isNotEmpty) {
        modelAvailableAppointmentsUser?.data.forEach((date, appointments) {
          print('Date: $date');
          for (var appointment in appointments) {
            print('Appointment ID: ${appointment.id}, Time: ${appointment.time}');
          }
        });
      } else {
        print('No appointments available.'); // Handle case where data is empty
      }
      emit(AgriScanStateSuccessTimeUser());
    }).catchError((error) {
      if (error is DioError) {
        if (error.response != null) {
          print('Error Response: ${error.response!.data}');
          print('Error Status Code: ${error.response!.statusCode}');
        } else {
          print('Error Message: ${error.message}');
        }
      } else {
        print('Unexpected Error: ${error.toString()}');
      }
      emit(AgriScanStateErrorTimeUser(error.toString()));
    });
  } else {
    print('Token is null');
    emit(AgriScanStateErrorTimeUser('Token is null'));
  }
}

ModelCreate? modelCreate;
int? bo;
void creatMeeting(int id,int y)
{
  emit(AgriScanStateLoadingCreat());

  if (token != null) {
    String tto = 'Bearer $token'; // Ensure tto is initialized correctly

    Diohelper.get(
      url:  '/users/create-meeting/$id',
      token: tto,
    ).then((value) {
      modelCreate=ModelCreate.fromJson(value.data);
      print(modelCreate?.success);
      timeEng(y);
      emit(AgriScanStateSuccessCreat());
    }).catchError((error) {
      if (error is DioError) {
        if (error.response != null) {
          print('Error Response: ${error.response!.data}');
          print('Error Status Code: ${error.response!.statusCode}');
        } else {
          print('Error Message: ${error.message}');
        }
      } else {
        print('Unexpected Error: ${error.toString()}');
      }
      emit(AgriScanStateErrorCreat(error.toString()));
    });
  } else {
    print('Token is null');
    emit(AgriScanStateErrorCreat('Token is null'));
  }
}
ModelUpComingMeetingUser? modelUpComingMeetingUser;
void getUpCoingUser(){
  emit(AgriScanStateLoadingComingMeetingUser());

  if (token != null) {
    String tto = 'Bearer $token'; // Ensure tto is initialized correctly

    Diohelper.get(
      url:  UPCOMING,
      token: tto,
    ).then((value) {
      modelUpComingMeetingUser=ModelUpComingMeetingUser.fromJson(value.data);
      emit(AgriScanStateSuccessComingMeetingUser());
    }).catchError((error) {
      if (error is DioError) {
        if (error.response != null) {
          print('Error Response: ${error.response!.data}');
          print('Error Status Code: ${error.response!.statusCode}');
        } else {
          print('Error Message: ${error.message}');
        }
      } else {
        print('Unexpected Error: ${error.toString()}');
      }
      emit(AgriScanStateErrorComingMeetingUser(error.toString()));
    });
  } else {
    print('Token is null');
    emit(AgriScanStateErrorComingMeetingUser('Token is null'));
  }
}
ModelPlant? modelPlant;
  void getPlantData() {
    emit(AgriScanStateLoadingPlantData());

    Diohelper.get(
      url: PLANT,
    ).then((value) {
      modelPlant = ModelPlant.fromJson(value.data);
      print(modelPlant?.data);
      emit(AgriScanStateSuccessPlantData());
    }).catchError((error) {
      String errorMessage;

      if (error is DioError) {
        if (error.response != null) {
          // Server responded with an error
          print('Error Response: ${error.response!.data}');
          print('Error Status Code: ${error.response!.statusCode}');

          switch (error.response!.statusCode) {
            case 400:
              errorMessage = 'Bad request. Please try again.';
              break;
            case 404:
              errorMessage = 'Resource not found. Please check the URL.';
              break;
            case 500:
              errorMessage = 'Server error. Please try again later.';
              break;
            default:
              errorMessage = 'Unexpected error: ${error.response!.statusCode}';
          }
        } else {
          // Error setting up or sending the request
          print('Error Message: ${error.message}');
          errorMessage = 'Network error: ${error.message}';
        }
      } else {
        // Unexpected error
        print('Unexpected Error: ${error.toString()}');
        errorMessage = 'Unexpected error: ${error.toString()}';
      }

      emit(AgriScanStateErrorPlantData(errorMessage));
    });
  }
 ModelProdect? modelProdect;
  void getProdect()
  {
    emit(AgriScanStateLoadingProdecttData());

    Diohelper.get(
      url: PRODECT,
    ).then((value) {
      modelProdect=ModelProdect.fromJson(value.data);
      emit(AgriScanStateSuccessProdecttData());
    }).catchError((error) {
      String errorMessage;

      if (error is DioError) {
        if (error.response != null) {
          // Server responded with an error
          print('Error Response: ${error.response!.data}');
          print('Error Status Code: ${error.response!.statusCode}');

          switch (error.response!.statusCode) {
            case 400:
              errorMessage = 'Bad request. Please try again.';
              break;
            case 404:
              errorMessage = 'Resource not found. Please check the URL.';
              break;
            case 500:
              errorMessage = 'Server error. Please try again later.';
              break;
            default:
              errorMessage = 'Unexpected error: ${error.response!.statusCode}';
          }
        } else {
          // Error setting up or sending the request
          print('Error Message: ${error.message}');
          errorMessage = 'Network error: ${error.message}';
        }
      } else {
        // Unexpected error
        print('Unexpected Error: ${error.toString()}');
        errorMessage = 'Unexpected error: ${error.toString()}';
      }

      emit(AgriScanStateErrorProdecttData(errorMessage));
    });
  }
  ModelOrder? modelOrder;
  void getOrder()
  {
    emit(AgriScanStateLoadingOrder());

    if (token != null) {
      String tto = 'Bearer $token'; // Ensure tto is initialized correctly

      Diohelper.get(
        url:  ORDER,
        token: tto,
      ).then((value) {
       modelOrder=ModelOrder.fromJson(value.data);
        emit(AgriScanStateSuccessOrder());
      }).catchError((error) {
        if (error is DioError) {
          if (error.response != null) {
            print('Error Response: ${error.response!.data}');
            print('Error Status Code: ${error.response!.statusCode}');
          } else {
            print('Error Message: ${error.message}');
          }
        } else {
          print('Unexpected Error: ${error.toString()}');
        }
        emit(AgriScanStateErrorOrder(error.toString()));
      });
    } else {
      print('Token is null');
      emit(AgriScanStateErrorOrder('Token is null'));
    }
  }
}

