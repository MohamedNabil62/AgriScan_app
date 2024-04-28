import 'package:agriscan/layout/agriscan_layout.dart';
import 'package:agriscan/modules/agriscan_crops/corps_screen.dart';
import 'package:agriscan/modules/register_sc/register_screen.dart';
import 'package:agriscan/shared/components/authentication_button.dart';
import 'package:agriscan/shared/components/components.dart';
import 'package:agriscan/shared/components/constants.dart';
import 'package:agriscan/shared/components/curve.dart';
import 'package:agriscan/shared/components/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
                      Column(
                        children: [
                          CustomTextField(

                            hintText: 'Username',
                            icon: Icons.person,
                            keyboardType: TextInputType.name,
                            controller: _usernameController,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter a username';
                              }
                              // You can add more validation logic as needed
                              return null; // Return null if the input is valid
                            },
                            onChanged: (value) {
                              username = value != '' ? value : '';
                            },
                          ),
                          CustomTextField(
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

                               navigtorAndFinish(context, AgriScanLayout() );


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
  }
}
