
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../layout/cubit/cubit.dart';
import '../../../layout/cubit/state.dart';
import '../../../shared/components/components.dart';
import '../../../shared/components/constants.dart';
import '../../../shared/network/local/cache_helper.dart';
import '../../../shared/styles/IconBroken.dart';
import 'dart:io';

import '../../login_sc/login_screen.dart';
import 'edit_profile.dart';

class AgriScanSettingScreen extends StatelessWidget {
  const AgriScanSettingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AgriScanCubit,AgriScanStates>(
        builder: (context, state) {
          //  var usermodel=SocailCubit.get(context).mode;
          var profileImage=AgriScanCubit.get(context).profileImage;
          // var coverImage=SocailCubit.get(context).coverImage;
          return Scaffold(
            body:   Padding(
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
                                image:NetworkImage("https://img.freepik.com/premium-photo/plowing-sowing-maize-field-with-tractor_69477-55.jpg?w=360"),
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
                            backgroundImage: profileImage==null? NetworkImage("https://img.freepik.com/free-photo/senior-man-working-field-with-vegetables_329181-12425.jpg?t=st=1718673579~exp=1718677179~hmac=fa44deb322cfd56c7eb66ed7de36e50092e3a25d28e3e93be5604a1eba3060bd&w=360") as ImageProvider<Object>?:FileImage(profileImage),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text("${AgriScanCubit.get(context).agriScanDataUserModel?.data?.name}",
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        color: kDarkGreenColor
                    ),
                  ),
                  Text("${AgriScanCubit.get(context).agriScanDataUserModel?.data?.email}",
                    style: Theme.of(context).textTheme.caption,
                  ),
                  Row(children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 8.0,left: 60,right: 60),
                        child: OutlinedButton(
                            onPressed: (){
                              nevgitto(context,EditProfileScreen());
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
                  SizedBox(height: 5,),
                  Row(children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 8.0,left: 60,right: 60),
                        child: OutlinedButton(
                            onPressed: (){
                              AgriScanCubit.get(context).userLogout();
                            },
                            child:Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  IconBroken.Logout,
                                  size: 16,
                                  color: kDarkGreenColor,
                                ),
                                SizedBox(width: 10,),
                                Text('LOGOUT',
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
            ),
          );
        },
        listener:(context, state) {
          if(state is AgriScanLogoutSuccessState )
            CacheHelper.reomveData(kay: "token").then((value) =>
                navigtorAndFinish(context, LoginScreen())
            );
        }
    );
  }
}
