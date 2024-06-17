import 'package:agriscan/layout/cubit/cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../layout/cubit/state.dart';
import '../../../shared/components/components.dart';
import '../../../shared/components/constants.dart';
import '../../../shared/styles/IconBroken.dart';
import '../../../shared/styles/colors.dart';
var namecontrollerEngineer=TextEditingController();
var biocontrollerEngineer=TextEditingController();
var phonecontrollerEngineer=TextEditingController();
var formkeyEngineer=GlobalKey<FormState>();

class EditProfileScreenEngineer extends StatelessWidget {
  const EditProfileScreenEngineer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AgriScanCubit,AgriScanStates>(
      builder:(context, state) {
        //var usermodel=SocailCubit.get(context).mode;
        var profileImage=AgriScanCubit.get(context).profileImage;
        //  var coverImage=SocailCubit.get(context).coverImage;
        namecontrollerEngineer.text=AgriScanCubit.get(context).agriScanDataUserModel!.data!.name!;
        biocontrollerEngineer.text=AgriScanCubit.get(context).agriScanDataUserModel!.data!.email!;
        phonecontrollerEngineer.text='9745993267';
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
                AgriScanCubit.get(context).upDateEngDat(name:  namecontrollerEngineer.text, email: biocontrollerEngineer.text);
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
                                  image:NetworkImage("https://img.freepik.com/premium-photo/tractor-driver-wearing-jacket-standing-field-holding-tablet_118124-81563.jpg?w=826"),
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
                            backgroundImage:profileImage==null? NetworkImage("https://img.freepik.com/premium-photo/tractor-driver-wearing-jacket-standing-field-holding-tablet_118124-81563.jpg?w=826") as ImageProvider<Object>?:FileImage(profileImage),
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
              /*
                if(SocailCubit.get(context).profileImage!=null||SocailCubit.get(context).coverImage!=null)
                Padding(
                  padding: const EdgeInsets.all(14),
                  child: Row(
                    children: [
                      if(SocailCubit.get(context).profileImage!=null)
                      Expanded(
                        child: Column(
                          children: [
                            defaultbutton(
                                function: (){
                                  SocailCubit.get(context).uploadingProfileImage(name: namecontroller.text, bio: biocontroller.text, phone: phonecontroller.text,);
                                },
                                text: 'upload profile',
                              colo: myColor
                            ),
                            if(state is SocailUpdateLoadingState)
                            SizedBox(
                              height: 5,
                            ),
                            if(state is SocailUpdateLoadingState)
                            LinearProgressIndicator()
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      if(SocailCubit.get(context).coverImage!=null)
                      Expanded(
                        child: Column(
                          children: [
                            defaultbutton(
                                function: (){
                                  SocailCubit.get(context).uploadingCoverImage(name: namecontroller.text, bio: biocontroller.text, phone: phonecontroller.text);
                                },
                                text: 'upload cover',

                                colo: myColor
                            ),
                            if(state is SocailUpdateLoadingState)
                            SizedBox(
                              height: 5,
                            ),
                            if(state is SocailUpdateLoadingState)
                            LinearProgressIndicator()
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                if(SocailCubit.get(context).profileImage!=null||SocailCubit.get(context).coverImage!=null)
                SizedBox(
                  height: 4,
                ),

                 */
              Padding(
                padding: const EdgeInsets.all(14.0),
                child: Form(
                  key: formkeyEngineer,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    //     mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextFormField(
                        controller: namecontrollerEngineer,
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
                        controller: biocontrollerEngineer,
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
