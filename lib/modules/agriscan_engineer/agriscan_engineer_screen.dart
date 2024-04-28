import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../layout/cubit/cubit.dart';
import '../../layout/cubit/state.dart';
import '../../shared/components/components.dart';
import '../../shared/components/constants.dart';
import '../agriscan_crops/corps_details.dart';
import 'appointment_details.dart';

class AgriScanEngineerScreen extends StatelessWidget {
  const AgriScanEngineerScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AgriScanCubit,AgriScanStates>(
      builder: (context, state) {
        return ConditionalBuilder(
          condition: true,
          builder: (context) => ListView.separated(
              physics: BouncingScrollPhysics(),
              itemBuilder: (context, index){
                  return buildChatItem(context);
              },
              separatorBuilder: (context, index) =>meSlider(),
              itemCount: 10,
          ),
          fallback: (context) => Center(child: CircularProgressIndicator()),
        );
      }, listener:(context, state) {},
    );
  }
}

Widget buildChatItem(context) {

  return InkWell(
    onTap: (){
      nevgitto(context, WeekDaysList());
    },
    child:   Padding(
      padding: const EdgeInsets.only(top: 10.0,left: 15),
      child:   Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: (){
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PhotoScreen(
                    imageUrl: "assets/images/mohamed_nabil.jpg",
                    tag: 'photoTag', // Unique tag for the Hero transition
                  ),
                ),
              );
            },
            child: CircleAvatar(
              radius:25,
              backgroundImage: AssetImage("assets/images/mohamed_nabil.jpg"),
            ),
          ),
          SizedBox(
            width: 15,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Mohamed Nabil",
                  style: GoogleFonts.poppins(
                    color: kDarkGreenColor,
                  ),

                ),
                Row(
                  children: [
                    Text( '4 Star Rating',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          color: Colors.grey
                      ),
                    ),
                    SizedBox(width: 5,),
                    StarRating(
                      stars:4,
                      size: 16.0,
                      onChanged: (value) {},
                    )
                  ],
                ),
              ],),
          ),

        ],
      ),
    ),
  );}
class StarRating extends StatelessWidget {
  final int scale;
  final double stars;
  final Color? color;
  final double? size;
  final Function(double)? onChanged;

  const StarRating({
    this.scale = 5,
    this.stars = 0.0,
    this.size,
    this.color = Colors.orange,
    this.onChanged,
    Key? key,
  }) : super(key: key);

  Widget buildStar(BuildContext context, int index) {
    IconData icon;
    if (index >= stars) {
      icon = Icons.star_border;
    } else if (index > stars - 1 && index < stars) {
      icon = Icons.star_half;
    } else {
      icon = Icons.star;
    }
    return GestureDetector(
      onTap: () => onChanged!(index + 1.0),
      child: Icon(
        icon,
        color: color,
        size: size,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(
        scale,
            (index) => buildStar(context, index),
      ),
    );
  }
}
