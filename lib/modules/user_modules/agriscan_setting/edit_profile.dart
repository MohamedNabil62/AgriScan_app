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
          namecontroller.text='User';
          biocontroller.text='bio....';
          phonecontroller.text='8239789232';
          return  Scaffold(
            appBar: AppBar(
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
                TextButton(onPressed: (){}, child: Text("update".toUpperCase(),
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
                if(false)
                  LinearProgressIndicator(),
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
                                    image:NetworkImage("https://img.freepik.com/free-photo/portrait-farmer-holding-crate-full-strawberries-fruit-greenhouse_342744-504.jpg?t=st=1717108285~exp=1717111885~hmac=75034d1dff3337c47a3dc991fa930900d1e8732d909fa0f69e0586cce3056ac3&w=740"),
                                    fit: BoxFit.cover,
                                  )
                              ),
                            ),
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
                           backgroundImage:profileImage==null? NetworkImage('https://img.freepik.com/free-photo/portrait-farmer-holding-crate-full-strawberries-fruit-greenhouse_342744-504.jpg?t=st=1717108285~exp=1717111885~hmac=75034d1dff3337c47a3dc991fa930900d1e8732d909fa0f69e0586cce3056ac3&w=740') as ImageProvider<Object>?:FileImage(profileImage),
                         ),
                       ),
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
                        keyboardType: TextInputType.text,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return ("bio must not be empty");
                          }
                          return null;
                        },
                        decoration: InputDecoration(prefixIcon: const Icon(IconBroken.Info_Circle),
                            labelText: "Bio",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(0))
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        controller: phonecontroller,
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
                    ],
                  ),
                ),
              )
              ],),
            ),
          );
        },
        listener:(context, state) {},
    );
  }
}
