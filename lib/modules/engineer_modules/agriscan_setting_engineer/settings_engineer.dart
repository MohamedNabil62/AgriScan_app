import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../layout/cubit/cubit.dart';
import '../../../layout/cubit/state.dart';
import '../../../shared/components/components.dart';
import '../../../shared/components/constants.dart';
import '../../../shared/styles/IconBroken.dart';
import 'dart:io';

import 'edit_profile_engineer.dart';
class AgriScanSettingScreenEngineer extends StatelessWidget {
  const AgriScanSettingScreenEngineer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AgriScanCubit,AgriScanStates>(
        builder: (context, state) {
          //  var usermodel=SocailCubit.get(context).mode;
          var profileImage=AgriScanCubit.get(context).profileImage;
          // var coverImage=SocailCubit.get(context).coverImage;
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
              actions: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    children: [
                      Icon(
                        Icons.account_balance_wallet,
                        color: Colors.white,
                      ),
                      SizedBox(width: 8),
                      Text(
                        "\$${AgriScanCubit.get(context).agriScanDataUserModel?.data?.balance}", // Replace with actual balance
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
              backgroundColor: kDarkGreenColor,
            ),
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
                                image:NetworkImage("https://img.freepik.com/premium-photo/tractor-driver-wearing-jacket-standing-field-holding-tablet_118124-81563.jpg?w=826"),
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
                            backgroundImage: profileImage==null? NetworkImage("https://img.freepik.com/premium-photo/tractor-driver-wearing-jacket-standing-field-holding-tablet_118124-81563.jpg?w=826") as ImageProvider<Object>?:FileImage(profileImage),
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
                              nevgitto(context, EditProfileScreenEngineer());
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
            ),
          );
        },
        listener:(context, state) {}
    );
  }
}
