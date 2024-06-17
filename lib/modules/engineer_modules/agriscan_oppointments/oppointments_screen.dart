import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../../layout/cubit_eng/cubit.dart';
import '../../../layout/cubit_eng/state.dart';
import '../../../shared/components/constants.dart';
import '../../../shared/styles/IconBroken.dart';
import 'details_day_engineer.dart';
class WeekDaysListEngineer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EngAgriScanCubit, EngAgriScanStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = EngAgriScanCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: const Text(
              "Week Days",
              style: TextStyle(color: Colors.white),
            ),
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                IconBroken.Arrow___Left_2,
                color: Colors.white,
              ),
            ),
            backgroundColor: kDarkGreenColor,
          ),
          body: ListView.builder(
            itemCount: 7, // Number of days in a week
            itemBuilder: (context, index) {
              var now = DateTime.now().add(Duration(days: index));
              var formattedDate = DateFormat('EEEE dd/MM/yyyy').format(now);
              var apiFormattedDate = DateFormat('yyyy-MM-dd').format(now); // API formatted date
              return InkWell(
                onTap: () {
                  // Retrieve available appointments for the selected date
                  bool ch=true;
                  print(ch);
                  if (EngAgriScanCubit.get(context).modelAvailableAppointmentsEng!.data.isNotEmpty) {
                    EngAgriScanCubit.get(context).modelAvailableAppointmentsEng?.data.forEach((date, appointments) {
                      if(date==apiFormattedDate) {
                        ch=false;
                        print('---------------------${appointments.length}');
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                BookingPageEngineer(
                                  data: formattedDate,
                                  appointments: appointments,
                                  format: apiFormattedDate,
                                ),
                          ),
                        );
                      }
                    });
                    if(ch)
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BookingPageEngineer(
                          data: formattedDate,
                          appointments: [],
                          format: apiFormattedDate,
                        ),
                      ),
                    );
                  } else
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BookingPageEngineer(
                        data: formattedDate,
                        appointments: [],
                        format: apiFormattedDate,
                      ),
                    ),
                  );

                },
                child: Container(
                  padding: EdgeInsets.all(16.0),
                  margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Text(
                    formattedDate,
                    style: GoogleFonts.poppins(
                      color: kDarkGreenColor,
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
