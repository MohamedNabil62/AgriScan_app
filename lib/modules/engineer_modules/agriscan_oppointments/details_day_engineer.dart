import 'package:agriscan/models/ModelAvailableAppointmentsEng.dart';
import 'package:agriscan/shared/components/components.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../../layout/cubit/cubit.dart';
import '../../../layout/cubit/state.dart';
import '../../../layout/cubit_eng/cubit.dart';
import '../../../layout/cubit_eng/state.dart';
import '../../../shared/components/constants.dart';
import '../../../shared/styles/IconBroken.dart';
var textcon=TextEditingController();
var timecon=TextEditingController();
var timecon2=TextEditingController();
var datacon=TextEditingController();
var scf_key=GlobalKey<ScaffoldState>();
var formkey=GlobalKey<FormState>();
class  BookingPageEngineer extends StatelessWidget {
  var data;
  var format;
  List<Appointment> appointments;
  BookingPageEngineer({this.data,required this.appointments,this.format,Key? key,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer< EngAgriScanCubit, EngAgriScanStates>(
      builder: (context, state) {
        var cubit = EngAgriScanCubit.get(context);
        cubit.appointments.addAll(appointments);
        return Scaffold(
        key: scf_key,
        appBar:  AppBar(
          title:  Text(
            "$data",
            style: const TextStyle(color: Colors.white),
          ),
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              IconBroken.Arrow___Left_2,
              color: Colors.white,
            ),
          ),
          backgroundColor: kDarkGreenColor,
        ),
        body:  Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ConditionalBuilder(
              condition: appointments.isNotEmpty , //AgriScanCubit.get(context).hommodel != null && AgriScanCubit.get(context).categoriesmodel != null ,
              builder: (context) => Flexible(
                child: ListView.separated(
                  shrinkWrap: true,
                  separatorBuilder: (context, index) => SizedBox(height: 5),
                  itemBuilder: (context, index) => DataBookedEngineer(appointments,index,context),
                  itemCount:appointments.length,
                ),
              ),
              fallback: (context) => Padding(
                padding: const EdgeInsets.only(top: 350.0),
                child: Center(
                  child: SpinKitFadingCircle(
                    color: Colors.green,
                    size: 50,
                  ),
                ),
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            if (EngAgriScanCubit.get(context).staut) {
              if (formkey!.currentState!.validate()) {
                String x=timecon.text;
                x = (data as String) +' '+ x.substring(0, x.length - 3);
                List<String> parts = x.split(' ');
                String? formattedDateTime;
                if (parts.length >= 2) {
                  String dateAndTime = parts.sublist(1).join(' ');
                formattedDateTime = '$dateAndTime';
                  formattedDateTime= formatDateTime(formattedDateTime);
                  print(formattedDateTime);
                }
                //showToast(text:formattedDateTime as String , state: ToastState.SUCCESS);
                EngAgriScanCubit.get(context).setTime(time:formattedDateTime as String);
              }
            } else {
              scf_key.currentState!.showBottomSheet(
                    (context) => Container(
                  color: Colors.grey[300],
                  padding: EdgeInsets.all(20),
                  child: Form(
                    key: formkey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          height: 150,
                          child: Row(
                            children: [
                              Expanded(
                                flex: 3,
                                child: TextFormField(
                                  onTap: () {
                                    showTimePicker(
                                      context: context,
                                      initialTime: TimeOfDay.now(),
                                    ).then((value) {
                                      if (value != null) {
                                        // تعديل الوقت حسب الشروط
                                        TimeOfDay adjustedTime = adjustTime(value);
                                        timecon.text = adjustedTime.format(context).toString();
                                        print(adjustedTime.format(context));
                                      }
                                    });
                                  },
                                  keyboardType: TextInputType.phone,
                                  controller: timecon,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "time must not be empty";
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    labelText: 'Start Meeting',
                                    labelStyle: TextStyle(
                                      color: kDarkGreenColor,
                                      fontSize: 15,
                                    ),
                                    prefix: Padding(
                                      padding: const EdgeInsets.only(right: 5.0),
                                      child: Icon(
                                        Icons.watch_later_outlined,
                                        size: 15,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ).closed.then((value) {
                EngAgriScanCubit.get(context).ChangeBottemSheetState(
                  state: false,
                  icons: Icons.edit,
                );
              });

              EngAgriScanCubit.get(context).ChangeBottemSheetState(
                state: true,
                icons: Icons.done,
              );
            }
          },
          label: Text(
            EngAgriScanCubit.get(context).staut ? 'Done' : 'Add a data',
            style: TextStyle(fontSize: 16),
          ),
          icon: Icon(EngAgriScanCubit.get(context).icon),
          backgroundColor: kDarkGreenColor,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      );},
        listener: (context, state) {
           if(state is EngAgriScanStateSuccessSetAppointments)
             {
               if(EngAgriScanCubit.get(context).modelSetTime?.message != null)
               showToast(text:EngAgriScanCubit.get(context).modelSetTime?.message as String, state: ToastState.SUCCESS);
                if(EngAgriScanCubit.get(context).modelSetTime?.success==1)
                  {
                    EngAgriScanCubit.get(context).getAvailableAppointmentsEng();
                    Navigator.pop(context);
                    Navigator.pop(context);
                    }
                  }
             }
    );
  }
}
Widget DataBookedEngineer( List<Appointment> appointments,int index,context){
  TimeOfDay startTime = TimeOfDay(
    hour: int.parse(appointments[index].time.split(':')[0]),
    minute: int.parse(appointments[index].time.split(':')[1]),
  );

  int totalMinutes = startTime.hour * 60 + startTime.minute + 30;
  int endHour = totalMinutes ~/ 60 % 24;
  int endMinute = totalMinutes % 60;
  String formattedEndTime = '${endHour.toString().padLeft(2, '0')}:${endMinute.toString().padLeft(2, '0')}';
  return Column(
    children: [
      Padding(
        padding: EdgeInsets.only(top: 8.0,left: 8,right: 8),
        child: Container(
          height: 45,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: kDarkGreenColor,
          ),
          width: double.infinity,
          child:Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0,bottom: 8,left: 13),
                    child: Text('Form  ${appointments[index].time} to $formattedEndTime',
                      style: TextStyle(
                          color: Colors.white
                      ),
                    ),
                  ),
                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(right: 13.0),
                    child: Icon(Icons.delete,
                    color: Colors.white,
                    ),
                  )
                ],
              )
            ],),
        ),
      )
    ],
  );
}
TimeOfDay adjustTime(TimeOfDay time) {
  if (time.minute < 30) {
    return TimeOfDay(hour: time.hour, minute: 30);
  } else {
    int newHour = time.hour + 1;
    if (newHour == 24) newHour = 0; // Reset to 0 if it's midnight
    return TimeOfDay(hour: newHour, minute: 0);
  }
}
String formatDateTime(String input) {
  // Split the input into date and time parts
  List<String> parts = input.split(' ');

  if (parts.length >= 2) {
    // Extract the date and time parts
    String datePart = parts[0];
    String timePart = parts.sublist(1).join(' ');

    // Split the date part into day, month, and year
    List<String> dateParts = datePart.split('/');

    if (dateParts.length == 3) {
      // Reconstruct the date in the desired format
      String formattedDate = '${dateParts[2]}/${dateParts[1]}/${dateParts[0]}';

      // Convert time to 24-hour format if needed
      String formattedTime = convertTo24HourFormat1(timePart);

      // Combine the formatted date and time parts
      return '$formattedDate $formattedTime';
    }
  }

  return input; // Return original input if formatting fails
}
String convertTo24HourFormat1(String time) {
  TimeOfDay? timeOfDay = TimeOfDay(
      hour: int.parse(time.split(':')[0]), minute: int.parse(time.split(':')[1].substring(0, 2)));

  if (time.contains('PM') && timeOfDay.hour < 12) {
    timeOfDay = TimeOfDay(hour: timeOfDay.hour + 12, minute: timeOfDay.minute);
  } else if (time.contains('AM') && timeOfDay.hour == 12) {
    timeOfDay = TimeOfDay(hour: 0, minute: timeOfDay.minute);
  }

  return '${timeOfDay.hour.toString().padLeft(2, '0')}:${timeOfDay.minute.toString().padLeft(2, '0')}';
}
