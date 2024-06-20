import 'package:agriscan/layout/cubit_eng/cubit.dart';
import 'package:agriscan/layout/cubit_eng/state.dart';
import 'package:agriscan/shared/components/components.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../models/model_amount.dart';
import '../../../shared/components/constants.dart';
import '../../../shared/styles/IconBroken.dart';
import 'new_request_screen.dart';

class AgriWithDrawMoneyScreen extends StatelessWidget {
  const AgriWithDrawMoneyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EngAgriScanCubit,EngAgriScanStates>(
      builder: (context, state) {
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
                condition: EngAgriScanCubit.get(context).modelAmount != null, //AgriScanCubit.get(context).hommodel != null && AgriScanCubit.get(context).categoriesmodel != null ,
                builder: (context) => Flexible(
                  child: ListView.separated(
                    shrinkWrap: true,
                    separatorBuilder: (context, index) => SizedBox(height: 5),
                    itemBuilder: (context, index) => bluidItemWithDrawMoney(EngAgriScanCubit.get(context).modelAmount!.data![index]),
                    itemCount: EngAgriScanCubit.get(context).modelAmount!.data!.length,
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
      },
      listener: (context, state) {

      },
    );
  }
}


Widget bluidItemWithDrawMoney(DataModelAmount dataModelAmount) => Padding(
  padding: EdgeInsets.only(top: 8.0,left: 8,right: 8),
  child: Container(
    height: 120,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      color: kDarkGreenColor,
    ),
    width: double.infinity,
    child:Padding(
      padding: const EdgeInsets.only(left: 15.0,top: 5,bottom: 5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Amount: ${dataModelAmount.amount}\$',
            style: TextStyle(
                color: Colors.white
            ),
          ),
          Text('Method:  ${dataModelAmount.method}', style: TextStyle(
              color: Colors.white
          ),),
          Text('Method Details: ${dataModelAmount.details}', style: TextStyle(
              color: Colors.white
          ),),
          Text('Status: ${dataModelAmount.status}', style: TextStyle(
              color: Colors.white
          ),),
        ],),
    ),
  ),
);