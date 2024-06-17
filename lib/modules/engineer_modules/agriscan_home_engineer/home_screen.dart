import 'package:agriscan/layout/cubit_eng/cubit.dart';
import 'package:agriscan/layout/cubit_eng/state.dart';
import 'package:agriscan/shared/components/components.dart';
import 'package:agriscan/shared/styles/IconBroken.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../shared/components/constants.dart';
import '../agriscan_oppointments/oppointments_screen.dart';
import '../agriscan_setting_engineer/settings_engineer.dart';
import '../agriscan_upcoming/agriscan_upcoming_screen.dart';
import '../agriscan_withdrawmoney/withdrawmoney_screen.dart';

class HomeEngineerScreen extends StatelessWidget {
  const HomeEngineerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (context) => EngAgriScanCubit()..getUpComingMeeting(),
    child: BlocConsumer<EngAgriScanCubit,EngAgriScanStates>(
      listener: (context, state) {

      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("AgriScan Engineer",
              style: TextStyle(
                  color: Colors.white
              ),

            ),
            backgroundColor: kDarkGreenColor ,
            actions: [
              IconButton(onPressed: (){
                nevgitto(context, AgriScanSettingScreenEngineer());
              }, icon:  Icon(IconBroken.Setting,
                color: Colors.white,
              ))
            ],
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Container(
                  width: 300,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: kDarkGreenColor,
                      elevation: 0.0,
                      textStyle: GoogleFonts.poppins(
                        fontSize: 15.0,
                        fontWeight: FontWeight.w500,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 12.0),
                    ),
                    child: const  Text("Upcoming Meeting"),
                    onPressed: () {
                      nevgitto(context, AgriUpcomingMeetingScreen());
                    },
                  ),
                ),
              ),
              SizedBox(height: 15,),
              Center(
                child: Container(
                  width: 300,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: kDarkGreenColor,
                      elevation: 0.0,
                      textStyle: GoogleFonts.poppins(
                        fontSize: 15.0,
                        fontWeight: FontWeight.w500,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 12.0),
                    ),
                    child: const  Text("Available appointments"),
                    onPressed: () {
                      nevgitto(context, WeekDaysListEngineer());
                    },
                  ),
                ),
              ),
              SizedBox(height: 15,),
              Center(
                child: Container(
                  width: 300,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: kDarkGreenColor,
                      elevation: 0.0,
                      textStyle: GoogleFonts.poppins(
                        fontSize: 15.0,
                        fontWeight: FontWeight.w500,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 12.0),
                    ),
                    child: const  Text("Withdraw Money"),
                    onPressed: () {
                      nevgitto(context, AgriWithDrawMoneyScreen());
                    },
                  ),
                ),
              ),

            ],
          ),
        );
      },
    ),
    );
  }
}
