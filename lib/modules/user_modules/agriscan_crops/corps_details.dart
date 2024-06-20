import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../shared/components/constants.dart';

class PlantDetails extends StatefulWidget {
  final String? Des;
  final String? path;
  final String? name;

  PlantDetails(this.Des, this.path, this.name, {Key? key}) : super(key: key);

  @override
  State<PlantDetails> createState() => _PlantDetailsState();
}

class _PlantDetailsState extends State<PlantDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        leadingWidth: 0.0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CircleAvatar(
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
          ],
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.42,
            color: kSpiritedGreen,
            padding: const EdgeInsets.only(top: 40.0),
            child: Hero(
              tag: 'plant',
              child: CachedNetworkImage(
                imageUrl: "https://acms-testing.smaster.live/${widget.path}",
                placeholder: (context, url) => Center(child: CircularProgressIndicator()),
                errorWidget: (context, url, error) => Icon(Icons.error),
                fit: BoxFit.cover,
              ),
            ),
          ),

          Container(
            color: kSpiritedGreen,
            height: MediaQuery.of(context).size.height * 0.58,
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40.0),
                  topRight: Radius.circular(40.0),
                ),
              ),
              padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 20.0),
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(top: 15.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.name ?? '',
                                textAlign: TextAlign.start,
                                style: GoogleFonts.poppins(
                                  fontSize: 28.0,
                                  fontWeight: FontWeight.w600,
                                  color: kDarkGreenColor,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 0.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                              'About',
                              style: GoogleFonts.poppins(
                                color: kDarkGreenColor,
                                fontSize: 16.0,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Html(
                                data: widget.Des ?? '',
                              ),
                            ),
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

class PlantMetricsWidget extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;

  const PlantMetricsWidget({
    required this.title,
    required this.value,
    required this.icon,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80.0,
      width: 120.0,
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 5.0,
            spreadRadius: 1.0,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            backgroundColor: kDarkGreenColor,
            radius: 28.0,
            child: Icon(
              icon,
              color: Colors.white,
              size: 30.0,
            ),
          ),
          Text(
            title,
            style: GoogleFonts.poppins(
              fontSize: 16.0,
              fontWeight: FontWeight.w500,
              color: kGreyColor,
            ),
          ),
          Text(
            value,
            style: GoogleFonts.poppins(
              fontSize: 16.0,
              fontWeight: FontWeight.w600,
              color: kDarkGreenColor,
            ),
          ),
        ],
      ),
    );
  }
}

class StarRating extends StatelessWidget {
  final int scale;
  final double stars;
  final Color? color;
  final Function(double)? onChanged;

  const StarRating({
    this.scale = 5,
    this.stars = 0.0,
    this.color = Colors.orange,
    this.onChanged,
    Key? key,
  }) : super(key: key);

  Widget buildStar(BuildContext context, int index) {
    IconData icon;
    if (index >= stars) {
      icon = Icons.star_border;
    } else if (index > stars - 1 && index < stars) {
      icon = Icons.star_half;
    } else {
      icon = Icons.star;
    }
    return GestureDetector(
      onTap: () => onChanged!(index + 1.0),
      child: Icon(
        icon,
        color: color,
        size: 30.0,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        scale,
            (index) => buildStar(context, index),
      ),
    );
  }
}
