import 'package:cached_network_image/cached_network_image.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../layout/cubit/cubit.dart';
import '../../../layout/cubit/state.dart';
import '../../../models_user/prodect_model.dart';
import '../../../shared/components/components.dart';
import '../../../shared/components/constants.dart';
import 'last_orders.dart';
import 'equip_details.dart';

class AgriScanFarmEquipScreen extends StatelessWidget {
  const AgriScanFarmEquipScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AgriScanCubit,AgriScanStates>(
      builder:(context, state) =>Scaffold(
          body:ConditionalBuilder(
        condition:AgriScanCubit.get(context).modelProdect != null,
        builder:(context) => ListView.separated(
          itemBuilder: (context, index) =>productEquipbuider(context,AgriScanCubit.get(context).modelProdect!.data![index]) ,
          itemCount: AgriScanCubit.get(context).modelProdect!.data!.length,
          separatorBuilder: (context, index) => SizedBox(height: 0,),
        ),
        fallback: (context) => Center(
          child: SpinKitFadingCircle(
            color: Colors.green,
            size: 50,
          ),
        ),
      ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            nevgitto(context, AgriScanLastOrdersScreen());
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
      },
    );
  }
}
Widget productEquipbuider(BuildContext context, DataModelProdect dataModelProdect) => GestureDetector(
  onTap: () {
    nevgitto(context, EquipmentDetails(
      dataModelProdect.name,
      dataModelProdect.description,
      dataModelProdect.cover,
      dataModelProdect.price,
      dataModelProdect.id
    ));
  },
  child: Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container(
      decoration: BoxDecoration(
        color: kGinColor,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.only(topLeft: Radius.circular(12), bottomLeft: Radius.circular(12)),
            child: CachedNetworkImage(
              imageUrl: "https://acms-testing.smaster.live/${dataModelProdect.cover}",
              width: 100, // Adjust width as needed
              height: 100, // Adjust height as needed
              placeholder: (context, url) => Center(child: CircularProgressIndicator()),
              errorWidget: (context, url, error) => Icon(Icons.error),
              fit: BoxFit.cover,
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Name: ${dataModelProdect.name}",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.start,
                    style: GoogleFonts.poppins(
                      fontSize: 12.0,
                      fontWeight: FontWeight.w500,
                      color: kDarkGreenColor,
                    ),
                  ),
                  SizedBox(height: 7),
                  Text(
                    "Description: ${dataModelProdect.description}",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.start,
                    style: GoogleFonts.poppins(
                      fontSize: 12.0,
                      fontWeight: FontWeight.w500,
                      color: kDarkGreenColor,
                    ),
                  ),
                  SizedBox(height: 7),
                  Text(
                    "Price: ${dataModelProdect.price}\$",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.start,
                    style: GoogleFonts.poppins(
                      fontSize: 12.0,
                      fontWeight: FontWeight.w500,
                      color: kDarkGreenColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  ),
);
