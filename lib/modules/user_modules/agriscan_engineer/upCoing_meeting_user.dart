import 'package:agriscan/layout/cubit_eng/cubit.dart';
import 'package:agriscan/layout/cubit_eng/state.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../layout/cubit/cubit.dart';
import '../../../layout/cubit/state.dart';
import '../../../models/upComingMeeting.dart';
import '../../../models_user/model_creat_meeting.dart';
import '../../../models_user/model_upcoming_meeting_user.dart';
import '../../../shared/components/constants.dart';
import '../../../shared/styles/IconBroken.dart';
import '../../engineer_modules/agriscan_oppointments/details_day_engineer.dart';
void _openUrl(String? url) async {
  if (await canLaunch(url!)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
class AgriUpcomingMeetingScreenUser extends StatelessWidget {
  const AgriUpcomingMeetingScreenUser({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return BlocConsumer<AgriScanCubit, AgriScanStates>(
      listener: (context, state) {
        /*
        if (state is EngAgriScanStateErrorUpComingMeeting) {
          // Handle error state
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.error),
            ),
          );
        }

         */
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text(
              "AgriScan",
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
              BlocBuilder<AgriScanCubit, AgriScanStates>(
                builder: (context, state) {
                  var cubit = AgriScanCubit.get(context);
                  return ConditionalBuilder(
                    condition: cubit.modelUpComingMeetingUser != null && cubit.modelUpComingMeetingUser!.data != null && cubit.modelUpComingMeetingUser!.data!.isNotEmpty,
                    builder: (context) => Flexible(
                      child: ListView.separated(
                        shrinkWrap: true,
                        separatorBuilder: (context, index) => SizedBox(height: 5),
                        itemBuilder: (context, index) => buildItemUpcomingMeeting(cubit.modelUpComingMeetingUser!.data![index],context),
                        itemCount: cubit.modelUpComingMeetingUser!.data!.length,
                      ),
                    ),
                    fallback: (context) => Padding(
                      padding: const EdgeInsets.only(top: 380.0),
                      child: Center(
                        child: SpinKitFadingCircle(
                          color: Colors.green,
                          size: 50,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}

Widget buildItemUpcomingMeeting(DataModelUpComingMeetingUser data,context){
  if (data.status=='Meeting Finished'&& AgriScanCubit.get(context).rata) {
     print("---------------id-------${data.id} start at ${data.startAt}");
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      showRatingDialog(context, data.id as int);
      AgriScanCubit.get(context).rata = false;
    });
  }
 return Padding(
  padding: EdgeInsets.only(top: 8.0, left: 8, right: 8),
  child: Container(
    height: 150,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      color: kDarkGreenColor,
    ),
    width: double.infinity,
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Name: ${data.eng?.name}',
            style:  TextStyle(
              color: Colors.white,
            ),
          ),
          Text(
            'Start at: ${data.startAt}',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                'Link Meeting: ',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              Expanded(
                child: InkWell(
                  onTap: () {
                    _openUrl(data.url);
                  },
                  child: Text(
                    data.url ?? '',
                    maxLines:3,
                    style: TextStyle(
                      color: Colors.blue,
                      decoration: TextDecoration.underline,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  ),
);
}
void showRatingDialog(BuildContext context,int id) {
  int rating = 0; // Use initialRating to set the initial rating.

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            title: Text(
              'Rate Your Meeting',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            content: Container(
              height: 150,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            rating = 1;
                          });
                        },
                        child: Icon(Icons.star, color: rating >= 1 ? Colors.orange : Colors.grey),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            rating = 2;
                          });
                        },
                        child: Icon(Icons.star, color: rating >= 2 ? Colors.orange : Colors.grey),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            rating = 3;
                          });
                        },
                        child: Icon(Icons.star, color: rating >= 3 ? Colors.orange : Colors.grey),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            rating = 4;
                          });
                        },
                        child: Icon(Icons.star, color: rating >= 4 ? Colors.orange : Colors.grey),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            rating = 5;
                          });
                        },
                        child: Icon(Icons.star, color: rating >= 5 ? Colors.orange : Colors.grey),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Text(
                    rating > 0 ? 'You rated $rating stars!' : 'Tap a star to rate.',
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
                  child: TextButton(
                    onPressed: () {
                      AgriScanCubit.get(context).userRateMeeting(id: id, rate: rating);
                      print(rating);
                      AgriScanCubit.get(context).rata=false;
                      Navigator.of(context).pop(rating); // Pass the rating back when 'Okay' is pressed.
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
    },
  );
}
