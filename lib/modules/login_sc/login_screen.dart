import 'package:agriscan/layout/agriscan_layout.dart';
import 'package:agriscan/layout/cubit/cubit.dart';
import 'package:agriscan/modules/login_sc/cubit/state.dart';
import 'package:agriscan/shared/components/authentication_button.dart';
import 'package:agriscan/shared/components/components.dart';
import 'package:agriscan/shared/components/constants.dart';
import 'package:agriscan/shared/components/curve.dart';
import 'package:agriscan/shared/components/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../layout/cubit_eng/cubit.dart';
import '../../shared/network/local/cache_helper.dart';
import '../engineer_modules/agriscan_home_engineer/home_screen.dart';
import '../register_sc/register_screen.dart';
import 'cubit/cubit.dart';
final GlobalKey<FormState> formkeyEngineerLogin=GlobalKey<FormState>();
class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  static const String id = 'LoginScreen';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool rememberMe = false;
  String username = '';
  String password = '';
  var passwordcontroller=TextEditingController();
  var _usernameController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AgriScanLoginCubit,AgriScanLoginStates>(
      listener: (context, state) {
        if(state is AgriScanLoginSuccessState)
        {

          {
            CacheHelper.saveData(
                kay: "token",
                value:state.LoginModel.data?.token ).then((value) {
              token=CacheHelper.getData(kay: 'token');
              print("token-------------------------$token");
              AgriScanCubit.get(context).getToken();
              if(state.LoginModel.data?.user?.role=='user') {
                CacheHelper.saveData(kay: "eng", value: false).then((value) {
                  AgriScanCubit.get(context).getToken();
                  AgriScanCubit.get(context).getListEng();
                  AgriScanCubit.get(context).getProdect();
                  AgriScanCubit.get(context).getOrder();
                  AgriScanCubit.get(context).getUpCoingUser();
                  navigtorAndFinish(context, AgriScanLayout());
                });
              }
              if(state.LoginModel.data?.user?.role=='eng') {
                CacheHelper.saveData(kay: "eng", value: true).then((value) {
                  EngAgriScanCubit.get(context).getAvailableAppointmentsEng();
                  EngAgriScanCubit.get(context).getAmount();
                  EngAgriScanCubit.get(context).getUpComingMeeting();
                  navigtorAndFinish(context, HomeEngineerScreen());
                });
              }
            } );
          }
        }

      },
      builder: (context, state) {
        return Material(
          child: Stack(
            alignment: Alignment.bottomRight,
            fit: StackFit.expand,
            children: [
              // First Child in the stack
              ClipPath(
                clipper: ImageClipper(),
                child: Image.asset(
                  'assets/images/leaves.jpg',
                  alignment: Alignment.topCenter,
                  fit: BoxFit.fitWidth,
                ),
              ),
              // Second Child in the stack
              Positioned(
                height: MediaQuery.of(context).size.height * 0.67,
                width: MediaQuery.of(context).size.width,
                child: Scaffold(
                  body: SingleChildScrollView(
                    child: Container(
                      constraints: BoxConstraints(
                        maxHeight: MediaQuery.of(context).size.height * 0.67,
                        maxWidth: MediaQuery.of(context).size.width,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          // First Column
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'Welcome Back',
                                style: GoogleFonts.poppins(
                                  fontSize: 32.0,
                                  fontWeight: FontWeight.w600,
                                  color: kDarkGreenColor,
                                ),
                              ),
                              Text(
                                'Login to your account',
                                style: GoogleFonts.poppins(
                                  color: kGreyColor,
                                  fontSize: 15.0,
                                ),
                              )
                            ],
                          ),

                          // Second Column
                          Form(
                            key: formkeyEngineerLogin,
                            child: Column(
                              children: [
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
                                  hintText: 'Email',
                                  icon: Icons.email,
                                  keyboardType: TextInputType.name,
                                  controller: _usernameController,
                                  onChanged: (value) {
                                    username = value != '' ? value : '';
                                  },
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
                                  obscureText: true,
                                  keyboardType: TextInputType.visiblePassword,
                                  onChanged: (value) {
                                    password = value != '' ? value : '';
                                  },
                                ),
                              ],
                            ),
                          ),
                          if(state is AgriScanLoginErrorState)
                            Text("Email or password is wrong",style: TextStyle(
                                color: Colors.red
                            )
                              ,),
                          // Third Column
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 20.0,
                              right: 20.0,
                              bottom: 20.0,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                AuthenticationButton(
                                  label: 'Log In',
                                  onPressed: () {
                                    if(formkeyEngineerLogin.currentState!.validate()){
                                      AgriScanLoginCubit.get(context).userLogin(
                                        email: _usernameController.text,
                                        password: passwordcontroller.text,
                                      );
                                    }
                                  },
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 10.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Text(
                                        'Don\'t have an account ?',
                                        style: TextStyle(fontSize: 14.0),
                                      ),
                                      TextButton(
                                        style: ButtonStyle(
                                          foregroundColor:
                                          MaterialStateProperty.all(
                                              kDarkGreenColor),
                                        ),
                                        onPressed: () {
                                          nevgitto(context,SignupScreen() );
                                        },
                                        child: const Text(
                                          'Sign up',
                                          style: TextStyle(fontSize: 14.0),
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
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
