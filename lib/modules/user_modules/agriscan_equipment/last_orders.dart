import 'package:cached_network_image/cached_network_image.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../layout/cubit/cubit.dart';
import '../../../layout/cubit/state.dart';
import '../../../models_user/order_model.dart';
import '../../../shared/components/constants.dart';


class AgriScanLastOrdersScreen extends StatelessWidget {
  const AgriScanLastOrdersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AgriScanCubit.get(context).getOrder();
    return BlocConsumer<AgriScanCubit,AgriScanStates>(
      builder:(context, state) =>Scaffold(
        appBar:AppBar(
          title: Text("Orders"),
        ),
        body:ConditionalBuilder(
          condition:AgriScanCubit.get(context).modelOrder != null && AgriScanCubit.get(context).modelOrder!.data!.orders!.isNotEmpty,
          builder:(context) => ListView.separated(
            itemBuilder: (context, orderIndex) {
              // Get the current order
              OrdersModelOrder order = AgriScanCubit.get(context).modelOrder!.data!.orders![orderIndex];

              // Return a ListView.builder for order items within each order
              return ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, itemIndex) =>
                    productEquipbuider(
                        context,
                        order.orderItems![itemIndex], // Access order items directly for the current order
                        itemIndex // Pass itemIndex for unique identification
                    ),
                itemCount: order.orderItems!.length,
              );
            },
            itemCount: AgriScanCubit.get(context).modelOrder!.data!.orders!.length,
            separatorBuilder: (context, index) => SizedBox(height: 0,),
          ),
          fallback: (context) => Center(
            child: SpinKitFadingCircle(
              color: Colors.green,
              size: 50,
            ),
          ),
        ),
      ),
      listener: (context, state) {

      },
    );
  }
}
Widget productEquipbuider( context,OrderItemsModelOrder orderItemsModelOrder,int index) => GestureDetector(
  onTap:(){
  },
  child: Padding(
    padding: const EdgeInsets.all(4.0),
    child: Container(
      decoration: BoxDecoration(
        color: kGinColor,
        borderRadius: BorderRadius.circular(0.0),
      ),
      child: Container(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
           Padding(
              padding: EdgeInsets.all(0.0),
              child: ClipRRect(
                borderRadius: BorderRadius.only(topRight:Radius.circular(0),topLeft:Radius.circular(0) ),
                child: CachedNetworkImage(
                  imageUrl: "https://acms-testing.smaster.live/${orderItemsModelOrder.product!.cover}",
                  width: 100, // Adjust width as needed
                  height: 100, // Adjust height as needed
                  placeholder: (context, url) => Center(child: CircularProgressIndicator()),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Name: ${orderItemsModelOrder.product!.name} ",
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
                    Text("Number: ${orderItemsModelOrder.quantity}",
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
                    Text("Peice: ${orderItemsModelOrder.product!.price}\$",
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