import 'package:agriscan/layout/cubit/cubit.dart';
import 'package:agriscan/layout/cubit/state.dart';
import 'package:agriscan/shared/components/components.dart';
import 'package:agriscan/shared/components/constants.dart';
import 'package:agriscan/shared/styles/IconBroken.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../modules/user_modules/agriscan_cart/cart_screen.dart';
import 'cubit/state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class AgriScanLayout extends StatelessWidget {
   AgriScanLayout({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AgriScanCubit,AgriScanStates>(
      listener: (context, state) {},
      builder: (context, state){
        var cubit=AgriScanCubit.get(context);
        return Scaffold(
        appBar: AppBar(
          title: Text("AgriScan",
            style: TextStyle(
              color: Colors.white
            ),

          ),
          backgroundColor: kDarkGreenColor ,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 12.0),
              child:IconButton(onPressed: (){
                nevgitto(context, CartScreen());
              },
              icon: Icon(Icons.shopping_cart,
                color: Colors.white,
                size: 30,
              ),
              )
            )
          ],
        ),
        body:cubit.bottomScreens[cubit.curent_index] ,
          bottomNavigationBar:BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            elevation: 10,
            currentIndex: cubit.curent_index,
            onTap: (index){
              cubit.changeBottom(index);
            },
            items:  [
              BottomNavigationBarItem(
                  icon: Icon(
                      Icons.local_florist
                  ),
                  label: "Crops"
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.agriculture),
                  label: "FarmEquip"
              ),
              BottomNavigationBarItem(
                  icon:  FaIcon(
                    FontAwesomeIcons.robot, // Replace with the appropriate Machine Learning icon from FontAwesomeIcons
                    // Customize the color of the icon
                  ),
                  label: "ChatBot"
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.engineering),
                  label: "Engineers"
              ),
              BottomNavigationBarItem(
                  icon: Icon(IconBroken.Setting),
                  label: "Settings"
              )
            ],
            backgroundColor:kDarkGreenColor ,
          ),
      );
      }
    );
  }
}
