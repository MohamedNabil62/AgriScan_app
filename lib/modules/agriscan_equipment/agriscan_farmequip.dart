import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../layout/cubit/cubit.dart';
import '../../layout/cubit/state.dart';
import '../../shared/components/components.dart';
import '../../shared/components/constants.dart';
import '../agriscan_cart/last_orders.dart';
import 'equip_details.dart';

class AgriScanFarmEquipScreen extends StatelessWidget {
  const AgriScanFarmEquipScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AgriScanCubit,AgriScanStates>(
      builder:(context, state) =>Scaffold(
          body:ConditionalBuilder(
        condition:true,//AgriScanCubit.get(context).hommodel != null && AgriScanCubit.get(context).categoriesmodel != null ,
        builder:(context) => ListView.separated(
          itemBuilder: (context, index) =>productEquipbuider(context) ,
          itemCount: 7,
          separatorBuilder: (context, index) => SizedBox(height: 0,),
        ),//AgriScanCubit.get(context).hommodel as HomeModel,AgriScanCubit.get(context).categoriesmodel as CategoriesModel,context),
        fallback: (context) => Center(child: CircularProgressIndicator()),
      ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            nevgitto(context, AgriScanLastOrdersScreen());
            print('Floating Action Button pressed!');
          },
          label: Text('Orders'), // Text to display inside the button
          icon: Icon(Icons.shopping_cart), // Icon to display before the label
          backgroundColor: kDarkGreenColor, // Background color of the button
          foregroundColor: Colors.white, // Color of the label and icon
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10), // Adjust the value to change the corner radius
          ),
          tooltip: 'Orders',
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat, // Change the location of the button if needed
      ),
      listener: (context, state) {
        /*
        if(state is AgriScanSuccessFavoritesDataState)
        {
          if(!state.model.status)
          {
            showToast(
                text:state.model.message,
                state:ToastState.ERROR
            );
          }
        }

         */
      },
    );
  }
}
Widget productEquipbuider( context) => GestureDetector(
  onTap:(){
    nevgitto(context,  EquipmentDetails());
  },
  child: Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container(
      decoration: BoxDecoration(
        color: kGinColor,
        borderRadius: BorderRadius.circular(0.0),
      ),
      child: Container(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(0.0),
              child: ClipRRect(
                borderRadius: BorderRadius.only(topRight:Radius.circular(0),topLeft:Radius.circular(0) ),
                child: Image(
                  image:NetworkImage("https://img.freepik.com/premium-photo/equipment-automatic-irrigation-large-field_120225-743.jpg?w=740"),
                      height: 120,
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Name: automatic irrigation ",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.start,
                      style: GoogleFonts.poppins(
                        fontSize: 12.0,
                        fontWeight: FontWeight.w500,
                        color: kDarkGreenColor,
                      ),
                    ),
                    SizedBox(height: 7,),
                    Text("Des: Equipment for automatic irrigation of a large field",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.start,
                      style: GoogleFonts.poppins(
                        fontSize: 12.0,
                        fontWeight: FontWeight.w500,
                        color: kDarkGreenColor,
                      ),
                    ),
                    SizedBox(height: 7,),
                    Text("Peice: 10K\$",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.start,
                      style: GoogleFonts.poppins(
                        fontSize: 12.0,
                        fontWeight: FontWeight.w500,
                        color: kDarkGreenColor,
                      ),
                    ),
                  ],),
              ),
            )

          ],
        ),
      ),

    ),
  ),
);