import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../shared/components/components.dart';
import '../../../shared/components/constants.dart';
import '../../../shared/network/local/cache_helper.dart';
import '../../login_sc/login_screen.dart';
import 'cart_model.dart';
import 'cuibt/cuibt.dart';
import 'cuibt/state.dart';

bool cant=false;
bool citi=false;
String? selectcan;
String? selectciti;
var textcontroller=TextEditingController();
final formkeymobil=GlobalKey<FormState>();
final GlobalKey<FormState> newForm = GlobalKey<FormState>();

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  static String id = "CartScreen";

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  double subTotal = 0;
  double shippingCost = 50.0;

  void doTotal() {
    subTotal = 0;
    /*
    setState(() {
      for (var e in cartItems) {
        subTotal += e.quantity * e.plant.plantPrice;
      }
    });

     */
  }

  @override
  void initState() {
    doTotal();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //
    // This is the AppBar
    AppBar appBar = AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Colors.white,
      elevation: 0.0,
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
              splashRadius: 1.0,
              icon: Icon(
                Icons.arrow_back_ios_new,
                color: kDarkGreenColor,
                size: 24.0,
              ),
            ),
          ),
          Text(
            'My Cart',
            style: GoogleFonts.poppins(
              color: kDarkGreenColor,
              fontSize: 22.0,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(
            width: 40.0,
            child: IconButton(
              onPressed: () {},
              splashRadius: 1.0,
              icon: Icon(
                Icons.more_vert,
                color: kDarkGreenColor,
                size: 34.0,
              ),
            ),
          ),
        ],
      ),
    );

    double appbarHeight = appBar.preferredSize.height;
    double bottomPadding = MediaQuery.of(context).padding.bottom;
    double mainHeight =
        MediaQuery.of(context).size.height - appbarHeight - bottomPadding;

    return BlocConsumer<CartCubit,CartStates>(builder:(context, state) {
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: appBar,
        body: SafeArea(
          child: Form(
            key: newForm,
            child: Column(
              children: [
                Flexible(
                  flex: 7,
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Container(
                      height: mainHeight * 7 / 11 - 30,
                      padding: const EdgeInsets.only(
                        top: 10.0,
                        left: 20.0,
                        right: 20.0,
                      ),
                      child: ListView.builder(
                        itemCount: CartCubit.get(context).boradingg.length,
                        itemBuilder: (context, index) {
                          return cartItem(CartCubit.get(context).boradingg[index],index, context);
                        },
                      ),
                    ),
                  ),
                ),
                Flexible(
                  flex: 5,
                  child: Container(
                    padding: const EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30.0),
                        topRight: Radius.circular(30.0),
                      ),
                      boxShadow: [
                        BoxShadow(
                          spreadRadius: 1,
                          blurRadius: 5,
                          offset: Offset(-1, -6),
                          color: Colors.black12,
                        ),
                      ],
                      color: Colors.white,
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Container(
                            width: 200,
                            child: DropdownButton<String>(
                              hint: Padding(
                                padding: const EdgeInsets.only(right: 280),
                                child: Text('Country'),
                              ),
                              onChanged: (String? newValue) {
                                setState(() {
                                  selectcan = newValue;
                                });
                              },
                              items: <String>[
                                "United Arab Emirates"
                                //  Newcastle upon Tyne
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                              value: selectcan,
                            ),
                          ),
                          if (cant)
                            Text(
                              "Choose a country",
                              style: TextStyle(color: Colors.red),
                            ),
                          const SizedBox(height: 20),
                          DropdownButton<String>(
                            hint: Padding(
                              padding: const EdgeInsets.only(right: 300.0),
                              child: Text('Cities'),
                            ),
                            onChanged: (String? newValue) {
                              setState(() {
                                setState(() {
                                  selectciti = newValue;
                                });
                              });
                            },
                            items: <String>[
                              'Abu Dhabi',
                              'Dubai',
                              'Sharjah',
                              'Ajman',
                              'Umm Al Quwain',
                              'Ras Al Khaimah',
                              'Fujairah'
                            ].map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            value: selectciti,
                          ),
                          if (citi)
                            const Text(
                              "Choose a city",
                              style: TextStyle(color: Colors.red),
                            ),
                          const SizedBox(height: 20),
                          Container(
                            width: 100,
                            child: TextFormField(
                              keyboardType: TextInputType.number,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return ("zip code must not be empty");
                                }
                                if (value.length < 5) {
                                  return ("Zip code must be five numbers");
                                }
                                return null;
                              },
                              controller: textcontroller,
                              decoration: InputDecoration(
                                hintText: 'enter zip code',
                              ),
                            ),
                          ),
                          SizedBox(height: 5,),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Total:',
                                style: GoogleFonts.poppins(
                                  color: kDarkGreenColor,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                ' ${CartCubit.get(context).toprice}0 \$',
                                style: GoogleFonts.poppins(
                                  color: kDarkGreenColor,
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 5,),
                          ElevatedButton(
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
                            child: const Text('Place Your Order'),
                            onPressed: () {
                              if(selectcan != null)
                              {
                                print("1 true");
                                CartCubit.get(context).myMap['Country']=selectcan;
                                setState(() {
                                  cant=false;
                                });
                                if(selectciti != null)
                                {
                                  print("2 true");
                                  CartCubit.get(context).myMap['city']=selectciti;
                                  setState(() {
                                    citi=false;
                                  });
                                  if(newForm.currentState!.validate()) {
                                    print("3 true");
                                    CartCubit.get(context).myMap['zip']=textcontroller.text;
                                    print('------------------------- ${CartCubit.get(context).myMap}----------');
                                    if( CartCubit.get(context).listcart.isNotEmpty)
                                    {
                                      CartCubit.get(context).listcart=[];
                                    }
                                    for(int x=0;x<CartCubit.get(context).boradingg.length;x++)
                                    {
                                      CartCubit.get(context).listcart.add({'id':CartCubit.get(context).boradingg[x].id, 'quantity': CartCubit.get(context).boradingg[x].num});
                                    }
                                    print('------------------------- ${CartCubit.get(context).listcart}----------');
                                    if(CartCubit.get(context).boradingg.isEmpty)
                                    {
                                      showToast(
                                        text:'You haven\'t selected any products yet. Please select the products you would like to purchase' ,
                                        state:ToastState.ERROR,
                                      );
                                    }
                                    else
                                    {
                                      //token=CacheHelper.getData(kay: 'token');
                                      if(token == 'null' ||CartCubit.get(context).unUser)
                                      {
                                        CacheHelper.reomveData(kay: "token").then((value) {
                                          navigtorAndFinish(context, LoginScreen());
                                        });
                                        CartCubit.get(context).done=true;
                                      }else
                                      {
                                        CartCubit.get(context).userCart(myMap: CartCubit.get(context).myMap, listcart: CartCubit.get(context).listcart,value: token);
                                        CartCubit.get(context).done=true;
                                        CartCubit.get(context).unUser=true;
                                      }
                                    }
                                  }
                                }
                                else
                                {
                                  setState(() {
                                    citi=true;
                                  });
                                }
                              }
                              else
                              {
                                setState(() {
                                  cant=true;
                                });
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }, listener:(context, state) {
      if(state is CartSuccessState) {
        if (state.cartModel.success == 1 ) {
          while(CartCubit.get(context).done) {
            _openUrl(
                '${state.cartModel.data
                    ?.paymentUrl as String}');
            CartCubit.get(context).done=false;
          }
          //html.window.open('https://admin.smaster.live/api/test?par=${state.cartModel.data?.paymentUrl as String}', "_blank");
        }
      }
    },);
  }
}
Widget cartItem(BoradingModel? bording, int?x,context)
{
  return Container(
    height: 100.0,
    decoration: BoxDecoration(
      color: kGinColor,
      borderRadius: BorderRadius.circular(10.0),
    ),
    padding: const EdgeInsets.all(10.0),
    margin: const EdgeInsets.only(bottom: 16.0),
    child: Row(
      children: [
        Container(
          height: 80.0,
          width: 80.0,
          margin: const EdgeInsets.only(right: 15.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            image: DecorationImage(
              image: NetworkImage(
                  "https://acms-testing.smaster.live/${bording?.image}"),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // The First Widget
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "${bording?.name}",
                    style: GoogleFonts.poppins(
                      color: kDarkGreenColor,
                      fontSize: 16.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  IconButton(
                    onPressed: () {

                      CartCubit.get(context).rmove(x);
                    },
                    icon: const Icon(
                      Icons.delete,
                      color: Colors.red,
                      size: 25,
                    ),
                  ),
                ],
              ),


              // The third widget
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // This is Quantity Selector
                  Row(
                    children: [
                      quantityButton(
                        icon: Icons.remove,
                        onPressed: () {
                          CartCubit.get(context).minis(x!);
                        },
                      ),
                      SizedBox(
                        width: 31.0,
                        child: Text(
                          '${bording?.num}',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(
                            color: kDarkGreenColor,
                          ),
                        ),
                      ),
                      quantityButton(
                        icon: Icons.add,
                        onPressed: () {
                          CartCubit.get(context).add(x!);
                        },
                      ),
                    ],
                  ),

                  // Shows Total Price of the plant according to the quantity
                  Text(
                    '${bording?.Price} \$ ',
                    style: GoogleFonts.poppins(
                      color: Colors.green.shade600,
                      fontWeight: FontWeight.w500,
                      fontSize: 15.0,
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ],
    ),
  );
}
Widget quantityButton(
    {required IconData icon, required Function() onPressed}) {
  return Container(
    height: 22.0,
    width: 24.0,
    decoration: BoxDecoration(
      border: Border.all(
        width: 1.0,
        color: kDarkGreenColor,
      ),
      borderRadius: BorderRadius.circular(6.0),
    ),
    child: GestureDetector(
      onTap: onPressed,
      child: Icon(
        icon,
        size: 14.0,
      ),
    ),
  );
}
  void _openUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }