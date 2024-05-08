
import 'package:agriscan/layout/cubit/cubit.dart';
import 'package:agriscan/layout/cubit/state.dart';
import 'package:agriscan/shared/components/components.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
      image: "assets/images/growing-wheat-wind.jpg"
  ),
  BannerModel(
      image: "assets/images/bunch-white-cotton-branch.jpg"
  ),
  BannerModel(
      image: "assets/images/water-drops-tomatoes-with-blurred-background.jpg"
  ),
  BannerModel(
      image: "assets/images/green-plantation-with-harvest-village.jpg"
  ),
  BannerModel(
      image: "assets/images/beautiful-shot-cornfield-with-blue-sky.jpg"
  ),
  BannerModel(
      image: "assets/images/close-up-fresh-organic-eggplant-garden.jpg"
  ),

];

class BoradingModel{
  late final String? title;
  late final String? image;
  BoradingModel({
    @required this.title,
    @required  this.image
  });
}
List<BoradingModel>borading=[
  BoradingModel(
      title:"Wheat Plant" ,
      image: "assets/images/growing-wheat-wind.jpg"
  ),
  BoradingModel(
      title:"Wheat Plant" ,
      image: "assets/images/growing-wheat-wind.jpg"
  ),
  BoradingModel(
      title:"Wheat Plant" ,
      image: "assets/images/bunch-white-cotton-branch.jpg"
  ),
  BoradingModel(
      title:"Wheat Plant" ,
      image: "assets/images/green-plantation-with-harvest-village.jpg"
  ),
  BoradingModel(
      title:"Wheat Plant" ,
      image: "assets/images/beautiful-shot-cornfield-with-blue-sky.jpg"
  ),
  BoradingModel(
      title:"Wheat Plant" ,
      image: "assets/images/close-up-fresh-organic-eggplant-garden.jpg"
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
        fallback: (context) => Center(child: CircularProgressIndicator()),
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
              image: AssetImage("${e.image}"),
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
              childAspectRatio: 1/1,
              children: List.generate(
                 borading.length,
                      (index) =>productGridviewbuider( borading[index],context)
              ),
            ),
          ),
        )
      ],
    ),
  );
}

Widget productGridviewbuider( BoradingModel mod,context) => GestureDetector(
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
                  image: AssetImage("${mod.image}",),

                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("${mod.title}",
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