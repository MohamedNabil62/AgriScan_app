
import 'package:agriscan/layout/cubit/cubit.dart';
import 'package:agriscan/layout/cubit/state.dart';
import 'package:agriscan/shared/components/components.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../shared/components/constants.dart';
import 'corps_details.dart';

class BannerModel{
  late final String? image;
  BannerModel({
    @required  this.image
  });
}
List<BannerModel>banner=[
  BannerModel(
      image: "https://img.freepik.com/free-photo/taking-cotton-from-branch-by-farmer_114579-3992.jpg?t=st=1717091845~exp=1717095445~hmac=92fcc3c7a998fbf72144d61563ecbbfa8270031abad5fd4e0664f117c512b7c1&w=740"
  ),
  BannerModel(
      image: "https://img.freepik.com/premium-photo/fresh-tomatoes-basket-white-background_763111-9562.jpg?w=826"
  ),
  BannerModel(
      image: "https://img.freepik.com/free-photo/corn-field-organic-farming-concept_23-2148617247.jpg?t=st=1717091700~exp=1717095300~hmac=bc47817663d4bd59e6160b95284d2f7f0247d12806b96cd08895340ed2ab596a&w=740"
  ),
  BannerModel(
      image: "https://img.freepik.com/free-photo/close-up-golden-wheat-spices_23-2148262592.jpg?t=st=1717090848~exp=1717094448~hmac=27c2ce37b2da97154fcefb17dff8f5dbc57e8cd7cbfd10d68f71c03a57b6a222&w=740"
  ),
];
class AgriScanCropsScreen extends StatelessWidget {
  const AgriScanCropsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AgriScanCubit,AgriScanStates>(
      builder:(context, state) =>ConditionalBuilder(
        condition:true,//AgriScanCubit.get(context).hommodel != null && AgriScanCubit.get(context).categoriesmodel != null ,
        builder:(context) => productsBuilder(context),//AgriScanCubit.get(context).hommodel as HomeModel,AgriScanCubit.get(context).categoriesmodel as CategoriesModel,context),
        fallback: (context) => Center(
          child: SpinKitFadingCircle(
            color: Colors.green,
            size: 50,
          ),
        ),
      ),
      listener: (context, state) {
        /*
        if(state is AgriScanSuccessFavoritesDataState)
        {
          if(!state.model.status)
          {
            showToast(
                text:state.model.message,
                state:ToastState.ERROR
            );
          }
        }

         */
      },
    );
  }
}

Widget productsBuilder(context)//HomeModel model, context )
{
  return SingleChildScrollView(
    physics: BouncingScrollPhysics(),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CarouselSlider(
            items:banner.map((e) => Image(
              image: NetworkImage("${e.image}"),
              width: double.infinity,
              fit: BoxFit.cover,
            )
            ).toList() ,
            options: CarouselOptions(
                viewportFraction: 1,
                height: 180,
                initialPage: 0,
                enableInfiniteScroll: true,//
                reverse: false,//
                autoPlay: true,
                autoPlayInterval: Duration(seconds: 3),
                autoPlayAnimationDuration: Duration(seconds: 1),
                autoPlayCurve: Curves.fastOutSlowIn,
                scrollDirection: Axis.horizontal //
            )
        ),
        SizedBox(height: 10,),
        Padding(
          padding: const EdgeInsets.all(5.0),
          child: Container(
            child: GridView.count(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              mainAxisSpacing: 6,
              crossAxisSpacing: 6,
              childAspectRatio: 1/1.3,
              children: List.generate(
                6,
                      (index) =>productGridviewbuider( context)
              ),
            ),
          ),
        )
      ],
    ),
  );
}

Widget productGridviewbuider( context) => GestureDetector(
  onTap:(){
    nevgitto(context,  PlantDetails());
  },
  child: Container(
    decoration: BoxDecoration(
      color: kGinColor,
      borderRadius: BorderRadius.circular(20.0),
    ),
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(0.0),
              child: ClipRRect(
                borderRadius: BorderRadius.only(topRight:Radius.circular(20),topLeft:Radius.circular(20) ),
                child: Image(
                  image:NetworkImage("https://img.freepik.com/free-photo/close-up-golden-wheat-spices_23-2148262592.jpg?t=st=1717090848~exp=1717094448~hmac=27c2ce37b2da97154fcefb17dff8f5dbc57e8cd7cbfd10d68f71c03a57b6a222&w=740",),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Wheat",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.start,
                    style: GoogleFonts.poppins(
                      fontSize: 15.0,
                      fontWeight: FontWeight.w500,
                      color: kDarkGreenColor,
                    ),
                  ),
                ],),
            )

          ],
        ),
      ),

  ),
);