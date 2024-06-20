import 'package:agriscan/layout/cubit_eng/cubit.dart';
import 'package:agriscan/layout/cubit_eng/state.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../layout/cubit/cubit.dart';
import '../../../layout/cubit/state.dart';
import '../../../models/upComingMeeting.dart';
import '../../../models_user/model_creat_meeting.dart';
import '../../../models_user/model_upcoming_meeting_user.dart';
import '../../../shared/components/constants.dart';
import '../../../shared/styles/IconBroken.dart';
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
              BlocBuilder<AgriScanCubit, AgriScanStates>(
                builder: (context, state) {
                  var cubit = AgriScanCubit.get(context);
                  return ConditionalBuilder(
                    condition: cubit.modelUpComingMeetingUser != null && cubit.modelUpComingMeetingUser!.data != null && cubit.modelUpComingMeetingUser!.data!.isNotEmpty,
                    builder: (context) => Flexible(
                      child: ListView.separated(
                        shrinkWrap: true,
                        separatorBuilder: (context, index) => SizedBox(height: 5),
                        itemBuilder: (context, index) => buildItemUpcomingMeeting(cubit.modelUpComingMeetingUser!.data![index]),
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

Widget buildItemUpcomingMeeting(DataModelUpComingMeetingUser data) => Padding(
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
            'Status: ${data.status}',
            style: TextStyle(
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
