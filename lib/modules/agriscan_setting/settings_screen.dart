import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../shared/components/components.dart';
import '../../../shared/styles/IconBroken.dart';
import '../../layout/cubit/cubit.dart';
import '../../layout/cubit/state.dart';
import '../../shared/components/constants.dart';
import 'edit_profile.dart';
import 'dart:io';
class AgriScanSettingScreen extends StatelessWidget {
  const AgriScanSettingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AgriScanCubit,AgriScanStates>(
        builder: (context, state) {
        //  var usermodel=SocailCubit.get(context).mode;
          var profileImage=AgriScanCubit.get(context).profileImage;
         // var coverImage=SocailCubit.get(context).coverImage;
          return Padding(
            padding: const EdgeInsets.all(0.0),
            child: Column(
              children: [
                Container(
                  height: 230,
                  child: Stack(
                    alignment: AlignmentDirectional.bottomCenter,
                    children: [
                      Align(
                        child: Container(
                          height: 190,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(4),
                                topRight:  Radius.circular(4)
                            ),
                            image: DecorationImage(
                              image:AssetImage("assets/images/mohamed_nabil.jpg"),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        alignment: AlignmentDirectional.topCenter,
                      ),
                      CircleAvatar(
                        radius: 64,
                        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                        child: CircleAvatar(
                          radius:60,
                          backgroundImage: profileImage==null? AssetImage("assets/images/mohamed_nabil.jpg") as ImageProvider<Object>?:FileImage(profileImage),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Text("Mohamed Nabil",
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    color: kDarkGreenColor
                  ),
                ),
                Text("bio....",
                  style: Theme.of(context).textTheme.caption,
                ),
                Row(children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 8.0,left: 60,right: 60),
                      child: OutlinedButton(
                          onPressed: (){
                            nevgitto(context, EditProfileScreen());
                          },
                          child:Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                            Icon(
                              IconBroken.Edit,
                              size: 16,
                              color: kDarkGreenColor,
                            ),
                            SizedBox(width: 10,),
                            Text('Edit Profile',
                            style: TextStyle(
                              color:kDarkGreenColor
                            ),
                            )
                          ],)
                      ),
                    ),
                  ),
                ],),

              ],
            ),
          );
        },
        listener:(context, state) {}
    );
  }
}
