import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../shared/components/components.dart';
import '../../../shared/components/constants.dart';
import '../agriscan_cart/cart_screen.dart';
import '../agriscan_cart/cuibt/cuibt.dart';

class EquipmentDetails extends StatefulWidget {
  String? name;
  String? des;
  String? path;
  int? pris;
  int? id;
  EquipmentDetails(this.name,this.des,this.path,this.pris,this.id,{ Key? key}) : super(key: key);

  @override
  State<EquipmentDetails> createState() => _EquipmentDetailsState();
}

class _EquipmentDetailsState extends State<EquipmentDetails> {
  bool favorite = false;
  int quantity = 1;
  @override
  Widget build(BuildContext context) {
    bool ch=false;
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
              tag: '${widget.name}',
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
                                'Price: ${widget.pris}\$',
                                style: TextStyle(
                                  color: Colors.green.shade600,
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          Row(children: [
                            Container(
                              child:  Text(
                                'Total Price: ',
                                style: TextStyle(
                                  color: Colors.green.shade600,
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            SizedBox(height: 3,),
                            Container(
                              width: 150,
                              child: Text(
                                '${widget.pris! * CartCubit.get(context).x} \$',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                          ],),
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
                            '${widget.des}',
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
                            onPressed: () {
                              CartCubit.get(context).totalPrice();
                              nevgitto(context, CartScreen());
                            },
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
                          onPressed: () {
                            for(int x=0;x<CartCubit.get(context).boradingg.length;x++)
                            {
                              if(CartCubit.get(context).boradingg[x].id == widget.id)
                              {
                                setState(() {
                                  ch=true;
                                });
                                CartCubit.get(context).addList();
                                 print("ooooooooooooooooooooooooooooooo");
                                print(widget.id);
                              }
                            }
                            if(ch)
                            {
                              print(CartCubit.get(context).boradingg);
                              showToast(
                                text:'This item already exists' ,
                                state:ToastState.ERROR,
                              );
                            }
                            else{
                              print("pppppppppppppppppppppppppppppppppppppppppppppppp");
                              CartCubit.get(context).addValueList(widget.id, widget.path, widget.name, widget.pris.toString(),  CartCubit.get(context).x,widget.pris!.toDouble() * CartCubit.get(context).x as double);
                            }

                          },
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
                  CartCubit.get(context).changePriseMinis();
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
              '${CartCubit.get(context).x}',
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
                  CartCubit.get(context).changePrisePlus();
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
