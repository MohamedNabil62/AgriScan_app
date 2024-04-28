import 'package:agriscan/shared/components/authentication_button.dart';
import 'package:agriscan/shared/components/constants.dart';
import 'package:agriscan/shared/components/curve.dart';
import 'package:agriscan/shared/components/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
                      Column(
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
                            controller: namecontroller,
                            hintText: 'Full Name',
                            icon: Icons.person,
                            keyboardType: TextInputType.name,
                            onChanged: (value) {},
                          ),
                          CustomTextField(
                            controller: emailcontroller,
                            hintText: 'Email',
                            icon: Icons.mail,
                            keyboardType: TextInputType.emailAddress,
                            onChanged: (value) {},
                          ),
                          CustomTextField(
                            controller: passwordcontroller,
                            hintText: 'Password',
                            icon: Icons.lock,
                            keyboardType: TextInputType.visiblePassword,
                            onChanged: (value) {},
                          ),
                          CustomTextField(
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
                            /*
                                TextButton(
                                  onPressed: () {},
                                  style: ButtonStyle(
                                    foregroundColor: MaterialStateProperty.all(
                                        kDarkGreenColor),
                                  ),
                                  child: const Text(
                                    'Forgot Password ?',
                                  ),
                                )

                                 */
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                        child: AuthenticationButton(
                          label: 'Sign Up',
                          onPressed: () {},
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
  }
}
