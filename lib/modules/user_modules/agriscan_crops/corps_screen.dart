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
import 'package:cached_network_image/cached_network_image.dart';

import '../../../models_user/plant_model.dart';
import '../../../shared/components/constants.dart';
import 'corps_details.dart';

class BannerModel {
  final String? image;

  BannerModel({this.image});
}

List<BannerModel> banner = [
  BannerModel(
    image: "https://img.freepik.com/free-photo/taking-cotton-from-branch-by-farmer_114579-3992.jpg?t=st=1717091845~exp=1717095445~hmac=92fcc3c7a998fbf72144d61563ecbbfa8270031abad5fd4e0664f117c512b7c1&w=740",
  ),
  BannerModel(
    image: "https://img.freepik.com/premium-photo/fresh-tomatoes-basket-white-background_763111-9562.jpg?w=826",
  ),
  BannerModel(
    image: "https://img.freepik.com/free-photo/corn-field-organic-farming-concept_23-2148617247.jpg?t=st=1717091700~exp=1717095300~hmac=bc47817663d4bd59e6160b95284d2f7f0247d12806b96cd08895340ed2ab596a&w=740",
  ),
  BannerModel(
    image: "https://img.freepik.com/free-photo/close-up-golden-wheat-spices_23-2148262592.jpg?t=st=1717090848~exp=1717094448~hmac=27c2ce37b2da97154fcefb17dff8f5dbc57e8cd7cbfd10d68f71c03a57b6a222&w=740",
  ),
];

class AgriScanCropsScreen extends StatelessWidget {
  const AgriScanCropsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AgriScanCubit, AgriScanStates>(
      builder: (context, state) => ConditionalBuilder(
        condition: AgriScanCubit.get(context).modelPlant != null,
        builder: (context) => productsBuilder(context),
        fallback: (context) => Center(
          child: SpinKitFadingCircle(
            color: Colors.green,
            size: 50,
          ),
        ),
      ),
      listener: (context, state) {
        // Handle state changes if necessary
      },
    );
  }
}

Widget productsBuilder(BuildContext context) {
  return SingleChildScrollView(
    physics: BouncingScrollPhysics(),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CarouselSlider(
          items: banner.map((e) => CachedNetworkImage(
            imageUrl: e.image ?? '',
            placeholder: (context, url) => CircularProgressIndicator(),
            errorWidget: (context, url, error) => Icon(Icons.error),
            width: double.infinity,
            fit: BoxFit.cover,
          )).toList(),
          options: CarouselOptions(
            viewportFraction: 1,
            height: 180,
            initialPage: 0,
            enableInfiniteScroll: true,
            autoPlay: true,
            autoPlayInterval: Duration(seconds: 3),
            autoPlayAnimationDuration: Duration(seconds: 1),
            autoPlayCurve: Curves.fastOutSlowIn,
            scrollDirection: Axis.horizontal,
          ),
        ),
        SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.all(5.0),
          child: GridView.count(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            mainAxisSpacing: 6,
            crossAxisSpacing: 6,
            childAspectRatio: 1 / 1.1,
            children: List.generate(
              AgriScanCubit.get(context).modelPlant?.data?.length ?? 0,
                  (index) => productGridviewBuilder(context, AgriScanCubit.get(context).modelPlant?.data![index]),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget productGridviewBuilder(BuildContext context, DataModelPlant? dataModelPlant) => GestureDetector(
  onTap: () {
    nevgitto(context, PlantDetails(dataModelPlant?.description, dataModelPlant?.cover, dataModelPlant?.name));
  },
  child: Container(
    decoration: BoxDecoration(
      color: kGinColor,
      borderRadius: BorderRadius.circular(20.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.only(topRight: Radius.circular(20), topLeft: Radius.circular(20)),
          child: CachedNetworkImage(
            imageUrl: "https://acms-testing.smaster.live/${dataModelPlant?.cover}",
            placeholder: (context, url) => CircularProgressIndicator(),
            errorWidget: (context, url, error) => Icon(Icons.error),
            width: double.infinity,
            height: 150,
            fit: BoxFit.cover,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Text(
            dataModelPlant?.name ?? '',
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.start,
            style: GoogleFonts.poppins(
              fontSize: 15.0,
              fontWeight: FontWeight.w500,
              color: kDarkGreenColor,
            ),
          ),
        ),
      ],
    ),
  ),
);
