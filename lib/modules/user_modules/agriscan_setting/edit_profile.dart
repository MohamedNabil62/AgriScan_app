import 'package:agriscan/layout/cubit/cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../layout/cubit/state.dart';
import '../../../shared/components/components.dart';
import '../../../shared/components/constants.dart';
import '../../../shared/styles/IconBroken.dart';
import '../../../shared/styles/colors.dart';
var namecontroller=TextEditingController();
var biocontroller=TextEditingController();
var phonecontroller=TextEditingController();
var formkey=GlobalKey<FormState>();

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AgriScanCubit,AgriScanStates>(
      builder:(context, state) {
        //var usermodel=SocailCubit.get(context).mode;
        var profileImage=AgriScanCubit.get(context).profileImage;
        //  var coverImage=SocailCubit.get(context).coverImage;
        namecontroller.text=AgriScanCubit.get(context).agriScanDataUserModel!.data!.name!;
        biocontroller.text=AgriScanCubit.get(context).agriScanDataUserModel!.data!.email!;
        phonecontroller.text='9745993267';
        return  Scaffold(
          appBar:  AppBar(
            title: const Text(
              "Edit Profile",
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
            actions: [
              TextButton(onPressed: (){
                AgriScanCubit.get(context).upDateEngDat(name:  namecontroller.text, email: biocontroller.text);
              }, child: Text("update".toUpperCase(),
                style: TextStyle(
                    color: Colors.white
                ),
              ),
              ),
              SizedBox(width: 15,)
            ],
          ),
          body: SingleChildScrollView(
            child: Column(children: [
              if(state is AgriScanLoadingUpdateUserDataState)
                LinearProgressIndicator(),
              SizedBox(
                height: 0,
              ),
              Container(
                height: 230,
                child: Stack(
                  alignment: AlignmentDirectional.bottomCenter,
                  children: [
                    Align(
                      alignment: AlignmentDirectional.topCenter,
                      child: Stack(
                        alignment: AlignmentDirectional.topEnd,
                        children: [
                          Container(
                            height: 190,
                            width: double.infinity,
                            decoration:  BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(4),
                                    topRight:  Radius.circular(4)
                                ),
                                image: DecorationImage(
                                  image:NetworkImage("https://img.freepik.com/premium-photo/plowing-sowing-maize-field-with-tractor_69477-55.jpg?w=360"),
                                  fit: BoxFit.cover,
                                )
                            ),
                          ),
                          /*
                          Padding(
                            padding: const EdgeInsets.only(top: 6.0,right: 6),
                            child: CircleAvatar(
                              radius: 20,
                              backgroundColor: myColor,
                              child: IconButton(onPressed: (){
                                //SocailCubit.get(context).getCoverImage();
                              },
                                icon:Icon(
                                  IconBroken.Camera,
                                  size: 16,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          )

                           */
                        ],
                      ),
                    ),
                    Stack(
                      alignment: AlignmentDirectional.bottomEnd,
                      children: [
                        CircleAvatar(
                          radius: 64,
                          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                          child: CircleAvatar(
                            radius:60,
                            backgroundImage:profileImage==null? NetworkImage("https://img.freepik.com/free-photo/senior-man-working-field-with-vegetables_329181-12425.jpg?t=st=1718673579~exp=1718677179~hmac=fa44deb322cfd56c7eb66ed7de36e50092e3a25d28e3e93be5604a1eba3060bd&w=360") as ImageProvider<Object>?:FileImage(profileImage),
                          ),
                        ),
                        /*
                        CircleAvatar(
                          radius: 20,
                          backgroundColor: myColor,
                          child: IconButton(onPressed: (){
                            // SocailCubit.get(context).getProfileImage();
                          },
                            icon:Icon(
                              IconBroken.Camera,
                              size: 16,
                              color: Colors.white,
                            ),
                          ),
                        )

                         */
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(14.0),
                child: Form(
                  key: formkey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    //     mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextFormField(
                        controller: namecontroller,
                        keyboardType: TextInputType.name,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return ("name must not be empty");
                          }
                          return null;
                        },
                        decoration: InputDecoration(prefixIcon: const Icon(IconBroken.User),
                            labelText: "Name",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(0))

                        ),
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        controller: biocontroller,
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return ("email must not be empty");
                          }
                          if (value.isNotEmpty) {
                            for(int x=0;x<value.length;x++)
                            {
                              if(value[x]=='@' && value[x+1] !=''){
                                return null;
                              }
                            }
                            return ("The email must be a valid email address");
                          }
                          return null;
                        },
                        decoration: InputDecoration(prefixIcon: const Icon(Icons.email_outlined),
                            labelText: "Email",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(0))
                        ),
                      ),
                      /*
                      const SizedBox(height: 10),
                      TextFormField(
                        controller: phonecontrollerEngineer,
                        keyboardType: TextInputType.phone,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return ("phone must not be empty");
                          }
                          return null;
                        },
                        decoration: InputDecoration(prefixIcon: const Icon(IconBroken.Call),
                            labelText: "Phone",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(0))

                        ),
                      ),

                       */
                    ],
                  ),
                ),
              )
            ],),
          ),
        );
      },
      listener:(context, state) {
        if(state is AgriScanSuccessUpdateUserDataState)
        {
          //AgriScanCubit.get(context).getToken();
        }
      },
    );
  }
}

