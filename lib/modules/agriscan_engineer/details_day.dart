import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../shared/components/constants.dart';

class  BookingPage extends StatelessWidget {
  var data;
   BookingPage({this.data,Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${data}',
          style: GoogleFonts.poppins(
            color: kDarkGreenColor,
          ),
        ),
      ),
    );
  }
}
Widget DataBooked(){
  return Column(
    children: [

    ],
  );
}