import 'package:agriscan/layout/cubit/state.dart';
import 'package:agriscan/layout/cubit_eng/state.dart';
import 'package:agriscan/models/Model_new.dart';
import 'package:agriscan/models/model_amount.dart';
import 'package:agriscan/models/upComingMeeting.dart';
import 'package:agriscan/shared/components/components.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../models/ModelAvailableAppointmentsEng.dart';
import '../../models/SetTime.dart';
import '../../shared/components/constants.dart';
import '../../shared/network/end_points.dart';
import '../../shared/network/remote/dio_helper.dart';

class EngAgriScanCubit extends Cubit<EngAgriScanStates> {

  EngAgriScanCubit() :super(EngAgriScanInitialState());
  bool staut=false;
  IconData icon=Icons.edit;
  void ChangeBottemSheetState({
    @required bool? state,
    @required IconData? icons,
  }){
    icon=icons!;
    staut=state!;
    emit(AppChangeBottomSheetStateEng());
  }
  static EngAgriScanCubit get(context) => BlocProvider.of(context);
  ModelAvailableAppointmentsEng? modelAvailableAppointmentsEng;
  void getAvailableAppointmentsEng() {
    emit(EngAgriScanStateLoadingGetAvailableAppointments());

    if (token != null) {
      String tto = 'Bearer $token'; // Ensure tto is initialized correctly

      Diohelper.get(
        url: AvailableAppointmentsEng,
        token: tto,
      ).then((value) {
         modelAvailableAppointmentsEng = ModelAvailableAppointmentsEng.fromJson(value.data);
         print(modelAvailableAppointmentsEng?.data[0]);
        if (modelAvailableAppointmentsEng!.data.isNotEmpty) {
          modelAvailableAppointmentsEng?.data.forEach((date, appointments) {
            print('Date: $date');
            for (var appointment in appointments) {
              print('Appointment ID: ${appointment.id}, Time: ${appointment.time}');
            }
          });
        } else {
          print('No appointments available.'); // Handle case where data is empty
        }

        emit(EngAgriScanStateSuccessGetAvailableAppointments());
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
        emit(EngAgriScanStateErrorGetAvailableAppointments(error.toString()));
      });
    } else {
      print('Token is null');
      emit(EngAgriScanStateErrorGetAvailableAppointments('Token is null'));
    }
  }
  List<Appointment> appointments = [];

  ModelSetTime? modelSetTime;
  void setTime({
    required String time
  }) {
    emit(EngAgriScanStateLoadingSetAppointments());
    if (token != null) {
      String tto = 'Bearer $token';
      Diohelper.postData(
        url: SETTIME,
        token: tto,
        data: {
          'start_at': time,
        },
      ).then((value) {
        modelSetTime=ModelSetTime.fromJson(value?.data);
        print(modelSetTime?.data?.startAt);
        emit(EngAgriScanStateSuccessSetAppointments());
      }).catchError((error) {
        if (error is DioError) {
          if (error.response?.statusCode == 422) {
            print('Validation Error: ${error.response?.data}');
            emit(EngAgriScanStateErrorSetAppointments(
                'Validation Error: ${error.response?.data}'));
          } else {
            print('Dio Error: ${error.message}');
            emit(EngAgriScanStateErrorSetAppointments(
                'Dio Error: ${error.message}'));
          }
        } else {
          print('Unexpected Error: ${error.toString()}');
          emit(EngAgriScanStateErrorSetAppointments(
              'Unexpected Error: ${error.toString()}'));
        }
      });
    }
  }

  ModelUpComeingMeeting? modelUpComeingMeeting;
  void getUpComingMeeting()
  {
    emit(EngAgriScanStateLoadingUpComingMeeting());

    if (token != null) {
      String tto = 'Bearer $token'; // Ensure tto is initialized correctly

      Diohelper.get(
        url: UPCOMINGMEETING,
        token: tto,
      ).then((value) {
        modelUpComeingMeeting=ModelUpComeingMeeting.fromJson(value.data);
        print(modelUpComeingMeeting?.data![0].url);
        emit(EngAgriScanStateSuccessUpComingMeeting());
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
        emit(EngAgriScanStateErrorUpComingMeeting(error.toString()));
      });
    } else {
      print('Token is null');
      emit(EngAgriScanStateErrorUpComingMeeting('Token is null'));
    }
  }
  ModelAmount? modelAmount;
  void getAmount()
  {
    emit(EngAgriScanStateLoadingAmount());

    if (token != null) {
      String tto = 'Bearer $token'; // Ensure tto is initialized correctly

      Diohelper.get(
        url: AMOUNT,
        token: tto,
      ).then((value) {
       modelAmount=ModelAmount.fromJson(value.data);
        emit(EngAgriScanStateSuccessAmount());
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
        emit(EngAgriScanStateErrorAmount(error.toString()));
      });
    } else {
      print('Token is null');
      emit(EngAgriScanStateErrorAmount('Token is null'));
    }
  }
  ModelNewRqust? modelNewRqust;
  void newRqu({
    String? det,
    String? mothed,
    String? amount,
  }) {
    emit(EngAgriScanStateLoadingNewR());
    if (token != null) {
      String tto = 'Bearer $token';
      Diohelper.postData(
        url: NEW,
        token: tto,
        data: {
          'details': det,
          'method': mothed,
          'amount': amount,
        },
      ).then((value) {
        modelNewRqust = ModelNewRqust.fromJson(value!.data);
        showToast(text:modelNewRqust?.message as String , state: ToastState.SUCCESS);
        print(modelNewRqust?.message);
        emit(EngAgriScanStateSuccessNewR());
      }).catchError((error) {
        if (error is DioError) {
          if (error.response?.statusCode == 400) {
            var errorMessage = error.response?.data['message'];
            showToast(text: errorMessage , state: ToastState.ERROR);
            print('Validation Error: $errorMessage');
            emit(EngAgriScanStateErrorNewR('Validation Error: $errorMessage'));
          } else {
            print('Dio Error: ${error.message}');
            emit(EngAgriScanStateErrorNewR('Dio Error: ${error.message}'));
          }
        } else {
          print('Unexpected Error: ${error.toString()}');
          emit(EngAgriScanStateErrorNewR('Unexpected Error: ${error.toString()}'));
        }
      });
    }
  }

}

