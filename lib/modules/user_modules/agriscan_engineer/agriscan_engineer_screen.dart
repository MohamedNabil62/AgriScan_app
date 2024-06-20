import 'package:agriscan/modules/user_modules/agriscan_engineer/upCoing_meeting_user.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../layout/cubit/cubit.dart';
import '../../../layout/cubit/state.dart';
import '../../../models_user/List_eng.dart';
import '../../../shared/components/components.dart';
import '../../../shared/components/constants.dart';
import '../agriscan_crops/corps_details.dart';
import 'appointment_details.dart';

class AgriScanEngineerScreen extends StatelessWidget {
  const AgriScanEngineerScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AgriScanCubit,AgriScanStates>(
      builder: (context, state) {
        return Scaffold(
          body: ConditionalBuilder(
            condition:AgriScanCubit.get(context).modelListEng != null,
            builder: (context) => ListView.separated(
              physics: BouncingScrollPhysics(),
              itemBuilder: (context, index){
                return buildChatItem(context,AgriScanCubit.get(context).modelListEng!.data![index]);
              },
              separatorBuilder: (context, index) =>meSlider(),
              itemCount: AgriScanCubit.get(context).modelListEng!.data!.length,
            ),
            fallback: (context) => Padding(
              padding: const EdgeInsets.only(top: 350.0),
              child: Center(
                child: SpinKitFadingCircle(
                  color: Colors.green,
                  size: 50,
                ),
              ),
            ),
          ),
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () {
              nevgitto(context,  AgriUpcomingMeetingScreenUser());
            },
            label: Text('UpComingMeeting'), // Text to display inside the button
            icon: Icon(Icons.meeting_room_outlined), // Icon to display before the label
            backgroundColor: kDarkGreenColor, // Background color of the button
            foregroundColor: Colors.white, // Color of the label and icon
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10), // Adjust the value to change the corner radius
            ),
            tooltip: 'UpComingMeeting',
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat, //
        );
      }, listener:(context, state) {},
    );
  }
}
Widget buildChatItem(context,DataModelListEng dataModelListEng) {
 if(dataModelListEng!.rates!.overRating==null)
 {
   dataModelListEng!.rates!.overRating=0;
 }
  return InkWell(
    onTap: (){
      AgriScanCubit.get(context).timeEng(dataModelListEng.id as int);
      nevgitto(context, WeekDaysList(dataModelListEng.id as int));
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
                Text(dataModelListEng.name as String??'',
                  style: GoogleFonts.poppins(
                    color: kDarkGreenColor,
                  ),

                ),
                Row(
                  children: [
                    Text( dataModelListEng!.rates!.overRating.toString(),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          color: Colors.grey
                      ),
                    ),
                    SizedBox(width: 5,),
                    StarRating(
                      stars:dataModelListEng!.rates!.overRating?.toDouble()??0.0,
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
