import 'package:agriscan/shared/components/components.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../../../shared/components/constants.dart';
import '../../../shared/styles/IconBroken.dart';
import 'details_day.dart';

class WeekDaysList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
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
          // Calculate date for each day using intl library
          var now = DateTime.now().add(Duration(days: index));
          var formattedDate = DateFormat('EEEE dd/MM/yyyy').format(now);

          return InkWell(
            onTap: (){
              nevgitto(context, BookingPage(data: formattedDate,));
            },
            child: Container(
              padding: EdgeInsets.all(16.0),
              margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Text(formattedDate,
                style: GoogleFonts.poppins(
                  color: kDarkGreenColor,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
