import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../shared/components/constants.dart';

class EquipmentDetails extends StatefulWidget {
  const EquipmentDetails({ Key? key}) : super(key: key);

  @override
  State<EquipmentDetails> createState() => _EquipmentDetailsState();
}

class _EquipmentDetailsState extends State<EquipmentDetails> {
  bool favorite = false;
  int quantity = 1;
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
              tag: 'automatic irrigation',
              child: Image.network("https://img.freepik.com/premium-photo/equipment-automatic-irrigation-large-field_120225-743.jpg?w=740"),
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
              padding:
              const EdgeInsets.symmetric(vertical: 24.0, horizontal: 20.0),
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
                           'Automatic Irrigation ',
                            textAlign: TextAlign.start,
                            style: GoogleFonts.poppins(
                              fontSize: 20.0,
                              fontWeight: FontWeight.w600,
                              color: kDarkGreenColor,
                            ),
                          ),
                          const SizedBox(height: 4.0),
                          Row(
                            children: [
                              Text(
                                '10k\$',
                                style: TextStyle(
                                  color: Colors.green.shade600,
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      QuantitySelector(
                        min: 1,
                        max: 8,
                        initial: 1,
                        onChanged: (value) {
                          setState(() {
                            quantity = value;
                          });
                        },
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 22.0),
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
                          padding:
                          const EdgeInsets.only(top: 10.0, bottom: 20.0),
                          child: Text(
                            'Automatic irrigation systems are advanced methods used in agriculture and landscaping to efficiently distribute water to crops, lawns, gardens, and other vegetation. Here\'s some detailed information about automatic irrigation:',
                            style: GoogleFonts.poppins(
                              color: kDarkGreenColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 24.0),
                        child: CircleAvatar(
                          backgroundColor: kGinColor,
                          radius: 26.0,
                          child: IconButton(
                            color: Colors.white,
                            splashRadius: 28.0,
                            icon: Icon(
                              Icons.shopping_cart_outlined,
                              color: kDarkGreenColor,
                              size: 28.0,
                            ),
                            onPressed: () {},
                          ),
                        ),
                      ),
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: kDarkGreenColor,
                            elevation: 20.0,
                            textStyle: GoogleFonts.poppins(
                              fontSize: 15.0,
                              fontWeight: FontWeight.w500,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 12.0),
                          ),
                          child:  Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.shopping_bag_outlined,
                                size: 24.0,
                              ),
                              SizedBox(width: 10.0),
                              Text(
                                'Add to Card',
                              ),
                            ],
                          ),
                          onPressed: () {},
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),

    );
  }
}



class QuantitySelector extends StatefulWidget {
  const QuantitySelector({
    required this.min,
    required this.max,
    required this.initial,
    required this.onChanged,
    Key? key,
  }) : super(key: key);

  final int min;
  final int max;
  final int initial;
  final Function(int) onChanged;

  @override
  State<QuantitySelector> createState() => _QuantitySelectorState();
}

class _QuantitySelectorState extends State<QuantitySelector> {
  late int quantity;

  @override
  void initState() {
    quantity = widget.initial;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 32.0,
      width: 95.0,
      decoration: BoxDecoration(
        color: kDarkGreenColor,
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  widget.onChanged(
                      quantity != widget.min ? --quantity : widget.min);
                });
              },
              child: const Icon(
                Icons.remove,
                color: Colors.white,
                size: 18.0,
              ),
            ),
          ),
          Align(
            child: Text(
              '$quantity',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16.0,
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  widget.onChanged(
                      quantity != widget.max ? ++quantity : widget.max);
                });
              },
              child: const Icon(
                Icons.add,
                color: Colors.white,
                size: 18.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
