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
import 'layout/cubit_eng/cubit.dart';
import 'modules/engineer_modules/agriscan_home_engineer/home_screen.dart';
import 'modules/login_sc/cubit/cubit.dart';
import 'modules/login_sc/login_screen.dart';
import 'modules/register_sc/cubit/cubit.dart';
import 'modules/user_modules/agriscan_cart/cuibt/cuibt.dart';
bool userDataCheck=false;
Future main() async{
  //يتاكد ان كل حاجه هنا  في الفانكشن خلصت وبعد كده يفتح الابلكيشن
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  Diohelper.init();
  await CacheHelper.init();
  bool? isDark=CacheHelper.getData(kay: 'mode');
  bool? cheng=CacheHelper.getData(kay: 'eng');
  token=CacheHelper.getData(kay: 'token');
  print(token);
  Widget? widget;
    if(token != null){
      if(cheng != null && cheng==true) {
        widget = HomeEngineerScreen();
      }
      else{
        widget = AgriScanLayout();
      }
    }
    else{
      widget=LoginScreen();
    }
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
            create: (context) => AgriScanCubit()..getToken()..getListEng()..getPlantData()..getProdect()..getOrder()..getUpCoingUser()
          ),
          BlocProvider(
              create: (context) => EngAgriScanCubit()..getAvailableAppointmentsEng()..getAmount()..getUpComingMeeting()
          ),
          BlocProvider(
              create: (context) => CartCubit(),),
    BlocProvider(create:(context) => AgriScanLoginCubit()),
    BlocProvider(create: (context) => AgriScanRegisterCubit()),
    ],
        child:BlocConsumer<AgriScanCubit,AgriScanStates>(
            listener:(context, state) =>{
             if(state is AgriScanErrorUserDataState)
               {
           CacheHelper.reomveData(kay: 'token').then((value) {}).catchError((e){
             print(e.toString());
           }),
                 userDataCheck=true,
                Start_Widget!=LoginScreen()
               }
            },
            builder:(context, state) {
              return  MaterialApp(debugShowCheckedModeBanner: false,
                  theme: lightmode,
                  darkTheme: darkmode,
                  themeMode:ThemeMode.light,
                  // themeMode:ThemeMode.dark,
                  home: Directionality(textDirection: TextDirection.ltr,
                    child:userDataCheck?LoginScreen():Start_Widget,
                  )
              );
            })
    );

  }
}