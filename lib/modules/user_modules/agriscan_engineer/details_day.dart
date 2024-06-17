import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../layout/cubit/cubit.dart';
import '../../../shared/components/constants.dart';
import '../../../shared/styles/IconBroken.dart';

class BookingPage extends StatefulWidget {
  final String? data;
  BookingPage({this.data, Key? key}) : super(key: key);

  @override
  _BookingPageState createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  // Set to store booked time slots
  Set<int> bookedSlots = Set();

  @override
  Widget build(BuildContext context) {
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
            condition: true, // Replace with your actual condition
            builder: (context) => Flexible(
              child: ListView.separated(
                shrinkWrap: true,
                separatorBuilder: (context, index) => SizedBox(height: 5),
                itemBuilder: (context, index) => DataBooked(index, isBooked(index)),
                itemCount: 5,
              ),
            ),
            fallback: (context) => Center(
              child: SpinKitFadingCircle(
                color: Colors.green,
                size: 50,
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          showBookingConfirmationDialog();
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
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  bool isBooked(int index) {
    return bookedSlots.contains(index);
  }

  void toggleBooking(int index) {
    setState(() {
      if (isBooked(index)) {
        bookedSlots.remove(index);
      } else {
        bookedSlots.add(index);

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


  Widget DataBooked(int index, bool isBooked) {
    return GestureDetector(
      onTap: () {
        toggleBooking(index);
      },
      child: Padding(
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
                      'From 12:30 pm to 1:00 pm',
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
                      child: isBooked
                          ? Icon(Icons.check, color: Colors.white)
                          : null,
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
