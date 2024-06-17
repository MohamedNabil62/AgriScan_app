import 'package:agriscan/shared/components/components.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../shared/components/constants.dart';
import '../../../shared/styles/IconBroken.dart';
import 'new_request_screen.dart';

class AgriWithDrawMoneyScreen extends StatelessWidget {
  const AgriWithDrawMoneyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "AgriScan Engineer",
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ConditionalBuilder(
            condition: true, //AgriScanCubit.get(context).hommodel != null && AgriScanCubit.get(context).categoriesmodel != null ,
            builder: (context) => Flexible(
              child: ListView.separated(
                shrinkWrap: true,
                separatorBuilder: (context, index) => SizedBox(height: 5),
                itemBuilder: (context, index) => bluidItemWithDrawMoney(),
                itemCount: 2,
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
          nevgitto(context, WithdrawScreen());
        },
        label: Text('New Request'), // Text to display inside the buttonIcon to display before the label
        backgroundColor: kDarkGreenColor, // Background color of the button
        foregroundColor: Colors.white, // Color of the label and icon
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10), // Adjust the value to change the corner radius
        ),
        tooltip: 'New Request',
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}


Widget bluidItemWithDrawMoney() => Padding(
  padding: EdgeInsets.only(top: 8.0,left: 8,right: 8),
  child: Container(
    height: 120,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      color: kDarkGreenColor,
    ),
    width: double.infinity,
    child:Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text('Amount: 500\$',
          style: TextStyle(
              color: Colors.white
          ),
        ),
        Text('Method:  Vodafone', style: TextStyle(
            color: Colors.white
        ),),
        Text('Method Details: 9856432', style: TextStyle(
            color: Colors.white
        ),),
        Text('Status: Verified', style: TextStyle(
            color: Colors.white
        ),),
      ],),
  ),
);