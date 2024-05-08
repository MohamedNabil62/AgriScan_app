// ignore_for_file: prefer_const_constructors, prefer_typing_uninitialized_variables


import 'package:agriscan/layout/agriscan_layout.dart';
import 'package:agriscan/layout/cubit/cubit.dart';
import 'package:agriscan/layout/cubit/state.dart';
import 'package:agriscan/shared/bloc_observre.dart';
import 'package:agriscan/shared/components/constants.dart';
import 'package:agriscan/shared/network/local/cache_helper.dart';
import 'package:agriscan/shared/network/remote/dio_helper.dart';
import 'package:agriscan/shared/styles/theme-data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'modules/user_modules/login_sc/login_screen.dart';


Future main() async{
  //يتاكد ان كل حاجه هنا  في الفانكشن خلصت وبعد كده يفتح الابلكيشن
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  Diohelper.init();
  await CacheHelper.init();
  bool? isDark=CacheHelper.getData(kay: 'mode');
 // bool? OnBorading=CacheHelper.getData(kay: 'onborading');
  token=CacheHelper.getData(kay: 'token');
  uId=CacheHelper.getData(kay: "uId");
  print(uId);
  Widget? widget;


    if(token != null){
      widget=AgriScanLayout();
    }
    else{
      widget=LoginScreen();
    }

  /*
  else{
    widget=onBorading();
  }

   */
  runApp(MyApp(isDark,widget));
}
class MyApp extends StatelessWidget
{
  final bool? isDark;
  final Widget Start_Widget;
  const MyApp(this.isDark, this.Start_Widget,{super.key});
  @override
  Widget build(BuildContext context) {
    return  MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => AgriScanCubit()//..getHomeData()..getCategoriesData()..getFavorites()..getUserModel(),
          ),
        ],
        child:BlocConsumer<AgriScanCubit,AgriScanStates>(
            listener:(context, state) => {
            },
            builder:(context, state) {
              return  MaterialApp(debugShowCheckedModeBanner: false,
                  theme: lightmode,
                  darkTheme: darkmode,
                  themeMode:ThemeMode.light,
                  // themeMode:ThemeMode.dark,
                  home: Directionality(textDirection: TextDirection.ltr,
                    child:AgriScanLayout(),
                  )
              );
            })



    );

  }
}