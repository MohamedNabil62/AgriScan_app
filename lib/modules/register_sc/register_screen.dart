import 'package:agriscan/modules/register_sc/cubit/state.dart';
import 'package:agriscan/shared/components/authentication_button.dart';
import 'package:agriscan/shared/components/constants.dart';
import 'package:agriscan/shared/components/curve.dart';
import 'package:agriscan/shared/components/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../layout/agriscan_layout.dart';
import '../../layout/cubit/cubit.dart';
import '../../layout/cubit_eng/cubit.dart';
import '../../shared/components/components.dart';
import '../../shared/network/local/cache_helper.dart';
import '../engineer_modules/agriscan_home_engineer/home_screen.dart';
import 'cubit/cubit.dart';
var namecontroller=TextEditingController();
var emailcontroller=TextEditingController();
var passwordcontroller=TextEditingController();
var phonecontroller=TextEditingController();
var formkey=GlobalKey<FormState>();
bool rememberMe = false;
class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AgriScanRegisterCubit,AgriScanRegisterStates>(listener: (context, state) {
      if (state is AgriScanRegisterSuccessState) {
        {
          CacheHelper.saveData(
              kay: "token",
              value:state.RegisterModel.data?.token ).then((value) {
            token=CacheHelper.getData(kay: 'token');
            print("token-------------------------$token");
            AgriScanCubit.get(context).getToken();
            if(state.RegisterModel.data?.user?.role=='user') {
              CacheHelper.saveData(kay: "eng", value: false).then((value) {
                AgriScanCubit.get(context).getToken();
                AgriScanCubit.get(context).getListEng();
                AgriScanCubit.get(context).getProdect();
                AgriScanCubit.get(context).getOrder();
                AgriScanCubit.get(context).getUpCoingUser();
                navigtorAndFinish(context, AgriScanLayout());
              });
            }
            if(state.RegisterModel.data?.user?.role=='eng') {
              CacheHelper.saveData(kay: "eng", value: true).then((value) {
                EngAgriScanCubit.get(context).getAvailableAppointmentsEng();
                EngAgriScanCubit.get(context).getAmount();
                EngAgriScanCubit.get(context).getUpComingMeeting();
                navigtorAndFinish(context, HomeEngineerScreen());
              });
            }
          } );
        }
      } else if (state is AgriScanRegisterErrorState) {
      }
    },
    builder: (context, state) {
      return Material(
        child: Stack(
          children: [
            Scaffold(
              body: SafeArea(
                child: SingleChildScrollView(
                  child: Container(
                    constraints: BoxConstraints(
                      maxHeight: MediaQuery.of(context).size.height * 0.9,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Form(
                          key: formkey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'Register',
                                style: GoogleFonts.poppins(
                                  fontSize: 32.0,
                                  fontWeight: FontWeight.w600,
                                  color: kDarkGreenColor,
                                ),
                              ),
                              const SizedBox(height: 10.0),
                              Text(
                                'Create a new account',
                                style: GoogleFonts.poppins(
                                  color: kGreyColor,
                                  fontSize: 16.0,
                                ),
                              ),
                              SizedBox(height: 40.0),
                              CustomTextField(
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return ("name must not be empty");
                                  }
                                  return null;
                                },
                                controller: namecontroller,
                                hintText: 'Full Name',
                                icon: Icons.person,
                                keyboardType: TextInputType.name,
                                onChanged: (value) {},
                              ),
                              CustomTextField(
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
                                controller: emailcontroller,
                                hintText: 'Email',
                                icon: Icons.mail,
                                keyboardType: TextInputType.emailAddress,
                                onChanged: (value) {},
                              ),
                              CustomTextField(
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return ("password must not be empty");
                                  }
                                  if(value.length < 8)
                                    return ("The password must be at least 8 characters");
                                  return null;
                                },
                                controller: passwordcontroller,
                                hintText: 'Password',
                                icon: Icons.lock,
                                keyboardType: TextInputType.visiblePassword,
                                onChanged: (value) {},
                              ),
                              CustomTextField(
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return ("phone number must not be empty");
                                  }
                                  return null;
                                },
                                controller: phonecontroller,
                                hintText: 'Phone Number',
                                icon: Icons.phone,
                                keyboardType: TextInputType.phone,
                                onChanged: (value) {},
                              ),
                              const SizedBox(height: 15.0),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'By signing you agree to our ',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.w600,
                                      color: kDarkGreenColor,
                                    ),
                                  ),
                                  Text(
                                    ' Terms of use',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.w600,
                                      color: kGreyColor,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'and ',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.w600,
                                      color: kDarkGreenColor,
                                    ),
                                  ),
                                  Text(
                                    ' privacy notice',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.w600,
                                      color: kGreyColor,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding:
                          const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Checkbox(
                                    checkColor: Colors.white,
                                    fillColor: MaterialStateProperty.all(
                                        kDarkGreenColor),
                                    value: rememberMe,
                                    onChanged: (value) {
                                      setState(() {
                                        rememberMe = value!;
                                        print(value);
                                      });
                                    },
                                  ),
                                  Text(
                                    'Register as an engineer',
                                    style: TextStyle(
                                      color: kGreyColor,
                                      fontSize: 14.0,
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                        if(state is AgriScanRegisterErrorState)
                          Center(
                            child: Text("The email has already been taken",style: TextStyle(
                                color: Colors.red
                            )),
                          ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                          child:  state is AgriScanRegisterLoadingState
                              ? const Center(
                        child: SpinKitFadingCircle(
                        color: Colors.green,
                          size: 50,
                        ),
                        ) : AuthenticationButton(
                            label: 'Sign Up',
                            onPressed: () {
                              if(formkey.currentState!.validate()){
                                AgriScanRegisterCubit.get(context).userRegister(
                                  name: namecontroller.text ,
                                  email: emailcontroller.text,
                                  password: passwordcontroller.text,
                                  phone: phonecontroller.text,
                                  eng:rememberMe?1:0,
                                );
                              }
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 30.0,
              left: 20.0,
              child: CircleAvatar(
                backgroundColor: Colors.grey.shade300,
                radius: 20.0,
                child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.arrow_back_ios_new,
                    color: kDarkGreenColor,
                    size: 24.0,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    },
    );
  }
}
