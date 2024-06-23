import 'package:agriscan/layout/cubit/state.dart';
import 'package:agriscan/shared/components/components.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../layout/cubit/cubit.dart';
import '../../../models_user/model_time.dart';
import '../../../shared/components/constants.dart';
import '../../../shared/styles/IconBroken.dart';
void _openUrl(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
class BookingPage extends StatefulWidget {
  var data;
  var format;
  int y;
  List<AppointmentUser> appointments;
  BookingPage({this.data, required this.appointments, this.format, required this.y, Key? key}) : super(key: key);

  @override
  _BookingPageState createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  // Variable to store the index of the booked time slot
  int? bookedSlot;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AgriScanCubit, AgriScanStates>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              "${widget.data}",
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
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ConditionalBuilder(
                condition: widget.appointments.isNotEmpty,
                builder: (context) => Flexible(
                  child: ListView.separated(
                    shrinkWrap: true,
                    separatorBuilder: (context, index) => SizedBox(height: 5),
                    itemBuilder: (context, index) => DataBooked(widget.appointments, index, context, isBooked(index)),
                    itemCount: widget.appointments.length,
                  ),
                ),
                fallback: (context) => Padding(
                  padding: const EdgeInsets.only(top: 380.0),
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
          floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
          floatingActionButton: state is AgriScanStateLoadingCreat
              ? Padding(
            padding: const EdgeInsets.only(top: 520.0),
            child: Center(
              child: SpinKitFadingCircle(
                color: Colors.green,
                size: 50,
              ),
            ),
          )
              : FloatingActionButton.extended(
            onPressed: () {
              if (AgriScanCubit.get(context).bo != null) {
                AgriScanCubit.get(context).creatMeeting(
                    widget.appointments[AgriScanCubit.get(context).bo as int].id, widget.y);
              } else {
                showToast(text: "Please choose a date", state: ToastState.ERROR);
              }
            },
            label: Text(
              "Booked",
              style: TextStyle(fontSize: 16),
            ),
            icon: Icon(Icons.book_online_outlined),
            backgroundColor: kDarkGreenColor,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        );
      },
      listener: (context, state) {
        if (state is AgriScanStateSuccessCreat) {
          _openUrl(AgriScanCubit.get(context).modelCreate?.data?.paymentUrl as String);

          Future.delayed(Duration(seconds: 3), () {
            showBookingConfirmationDialog();
          });
        }
      },
    );
  }

  bool isBooked(int index) {
    return bookedSlot == index;
  }

  void toggleBooking(int index) {
    setState(() {
      if (isBooked(index)) {
        bookedSlot = null;
      } else {
        bookedSlot = index;
      }
    });
  }

  void showBookingConfirmationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          content: Container(
            height: 150,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.check_circle,
                  color: Colors.green,
                  size: 50,
                ),
                SizedBox(height: 10),
                Text(
                  'Success',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Your booking has been confirmed!',
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          actions: [
            Center(
              child: Container(
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.blue,
                ),
                child: MaterialButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                    AgriScanCubit.get(context).timeEng(widget.y);

                  },
                  child: Text(
                    'Okay',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget DataBooked(List<AppointmentUser> appointments, int index, context, bool isBooked) {
    TimeOfDay startTime = TimeOfDay(
      hour: int.parse(appointments[index].time.split(':')[0]),
      minute: int.parse(appointments[index].time.split(':')[1]),
    );

    int totalMinutes = startTime.hour * 60 + startTime.minute + 30;
    int endHour = totalMinutes ~/ 60 % 24;
    int endMinute = totalMinutes % 60;
    String formattedEndTime = '${endHour.toString().padLeft(2, '0')}:${endMinute.toString().padLeft(2, '0')}';

    return GestureDetector(
      onTap: () {
        AgriScanCubit.get(context).bo = index;
        toggleBooking(index);
      },
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 8.0, left: 8, right: 8),
            child: Container(
              height: 45,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: kDarkGreenColor,
              ),
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0, bottom: 8, left: 13),
                        child: Text(
                          'From ${appointments[index].time} to $formattedEndTime',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      Spacer(),
                      Padding(
                        padding: const EdgeInsets.only(right: 13.0),
                        child: Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: isBooked ? Colors.green : Colors.white,
                          ),
                          child: isBooked ? Icon(Icons.check, color: Colors.white) : null,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
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

  return input;
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
