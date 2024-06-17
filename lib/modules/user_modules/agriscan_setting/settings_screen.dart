import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../layout/cubit/cubit.dart';
import '../../../layout/cubit/state.dart';
import '../../../shared/components/components.dart';
import '../../../shared/components/constants.dart';
import '../../../shared/styles/IconBroken.dart';
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
                              image:NetworkImage("https://img.freepik.com/free-photo/portrait-farmer-holding-crate-full-strawberries-fruit-greenhouse_342744-504.jpg?t=st=1717108285~exp=1717111885~hmac=75034d1dff3337c47a3dc991fa930900d1e8732d909fa0f69e0586cce3056ac3&w=740"),
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
                          backgroundImage: profileImage==null? NetworkImage("https://img.freepik.com/free-photo/portrait-farmer-holding-crate-full-strawberries-fruit-greenhouse_342744-504.jpg?t=st=1717108285~exp=1717111885~hmac=75034d1dff3337c47a3dc991fa930900d1e8732d909fa0f69e0586cce3056ac3&w=740") as ImageProvider<Object>?:FileImage(profileImage),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Text("User",
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
