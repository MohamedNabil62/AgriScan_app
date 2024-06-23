

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../network/local/cache_helper.dart';
import '../styles/IconBroken.dart';
import 'components.dart';

Widget text({String? data="App",double? fonts=20,Color? color=Colors.black})
{
  return Text(data!,
    style: TextStyle(
      fontSize: fonts,
      color:color
  ),
    textAlign: TextAlign.center,
  );
}
Widget appbar({String? data="App",double? fonts=20,Color? color=Colors.black,Widget? titiel})
{
  return AppBar(
    title: Text(data!,
      style: TextStyle(
          fontSize: fonts,
          fontWeight: FontWeight.bold,
          color:color
      ),
      textAlign: TextAlign.center,
    ),

  );
}
/*
void singeout(context){
  CacheHelper.reomveData(kay: "token").then((value) =>
      navigtorAndFinish(context,
          ShopLoginScreen()
      )
  );
}

 */

void printfulltext(String text)
{
  final pattern=RegExp(".{1,800}");
  pattern.allMatches(text).forEach((element) => print(element.group(0)));
}

String? token='';

String? uId='';


Color kDarkGreenColor = const Color(0xFF184A2C);
Color kGinColor = const Color(0xFFE5F0EA);
Color kSpiritedGreen = const Color(0xFFC1DFCB);
Color kFoamColor = const Color(0xFFEBFDF2);
Color kGreyColor = Colors.grey.shade600;

TextStyle kBillTextStyle = GoogleFonts.poppins(
  color: kDarkGreenColor,
  fontSize: 15.0,
);
class PhotoScreen extends StatelessWidget {
  final String imageUrl;
  final String tag;

  const PhotoScreen({required this.imageUrl, required this.tag});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading:IconButton(
          onPressed: (){
            Navigator.pop(context);
          },
          icon: Icon(
              IconBroken.Arrow___Left_2
          ),
        ),
      ),
      body: Center(
        child: Hero(
          tag: tag,
          child: Image.network(
            imageUrl,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  } }

