import 'package:agriscan/layout/cubit_eng/cubit.dart';
import 'package:agriscan/layout/cubit_eng/state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../shared/components/constants.dart';
import '../../../shared/components/custom_text_field.dart';
import '../../../shared/styles/IconBroken.dart';
String? selectedOption;
String? errorText;
TextEditingController textEditingController = TextEditingController();
var amountcontroller=TextEditingController();
var detailscontroller=TextEditingController();
final GlobalKey<FormState> formkeyNew=GlobalKey<FormState>();
class WithdrawScreen extends StatefulWidget {
  @override
  State<WithdrawScreen> createState() => _WithdrawScreenState();
}

class _WithdrawScreenState extends State<WithdrawScreen> {
  void _showOptions(BuildContext context) {
    final RenderBox textFieldRenderBox = context.findRenderObject() as RenderBox;
    final Offset textFieldOffset = textFieldRenderBox.localToGlobal(Offset.zero);

    showMenu(
      context: context,
      position: RelativeRect.fromLTRB(
        90,220,10,10
      ),
      items: [
        PopupMenuItem(
          child: Text('Vodafone',
          style: TextStyle(
            color: kDarkGreenColor
          ),
          ),
          value: 'Vodafone',
        ),
        PopupMenuItem(
          child: Text('Etisalat',
            style: TextStyle(
                color: kDarkGreenColor
            ),
          ),
          value: 'Etisalat',
        ),
        PopupMenuItem(
          child: Text('Bank',
            style: TextStyle(
                color: kDarkGreenColor
            ),
          ),
          value: 'Bank',
        ),
      ],
    ).then((selectedValue) {
      if (selectedValue != null) {
        setState(() {
          selectedOption = selectedValue as String;
         // textEditingController.text = selectedValue as String;
          errorText = null;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {

    return BlocConsumer<EngAgriScanCubit,EngAgriScanStates>(
      listener: (context, state) {
        if(state is EngAgriScanStateSuccessNewR)
            EngAgriScanCubit.get(context).getAmount();
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text(
              "Withdraw Money",
              style: TextStyle(color: Colors.white),
            ),
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                IconBroken.Arrow___Left_2,
                color: Colors.white,
              ),
            ),
            backgroundColor: kDarkGreenColor,
          ),
          body:Form(
            key: formkeyNew,
            child: Column(children: [
              Padding(
                padding: const EdgeInsets.only(left: 20.0,right: 20,bottom: 10,top: 20),
                child: TextFormField(
                  controller: amountcontroller,
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return ("Amount must not be empty");
                    }
                    return null;
                  },
                  decoration: InputDecoration(prefixIcon: const Icon(Icons.monetization_on_outlined),
                      labelText: "Enter Amount",
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: kDarkGreenColor
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      prefixIconColor: kDarkGreenColor,
                      suffixIconColor:kDarkGreenColor ,
                      labelStyle: TextStyle(
                          color: kDarkGreenColor
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))

                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0,right: 20,bottom: 10,top: 10),
                child: TextField(
                  controller: TextEditingController(text: selectedOption),
                  readOnly: true,
                  onTap: () {
                    _showOptions(context);
                  },
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: kDarkGreenColor
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    prefixIconColor: kDarkGreenColor,
                    suffixIconColor:kDarkGreenColor ,
                    labelStyle: TextStyle(
                        color: kDarkGreenColor
                    ),
                    labelText: 'Choose Withdrawal Option',
                    suffixIcon: Icon(Icons.keyboard_arrow_down_sharp),
                    prefixIcon: Icon(Icons.money_outlined),
                    errorText: errorText,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),

                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0,right: 20,bottom: 10,top: 10),
                child: TextFormField(
                  controller: detailscontroller,
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return ("method details must not be empty");
                    }
                    return null;
                  },
                  decoration: InputDecoration(prefixIcon: const Icon(Icons.format_list_numbered_rtl_outlined),
                      labelText: "Method details",
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: kDarkGreenColor
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      prefixIconColor: kDarkGreenColor,
                      suffixIconColor:kDarkGreenColor ,
                      labelStyle: TextStyle(
                          color: kDarkGreenColor
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      )
                  ),
                ),
              ),
            ],),
          ),
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () {

              print(selectedOption??'');
              if(formkeyNew.currentState!.validate() )
              {
                if(selectedOption==  null)
                {
                  setState(() {
                    errorText='choose withdrawal option';
                  });
                }
                else{
                   EngAgriScanCubit.get(context).newRqu(amount:amountcontroller.text ,mothed: selectedOption,det:detailscontroller.text );
                }
              }
            },
            label: Text('Request Now'), // Text to display inside the buttonIcon to display before the label
            backgroundColor: kDarkGreenColor, // Background color of the button
            foregroundColor: Colors.white, // Color of the label and icon
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10), // Adjust the value to change the corner radius
            ),
            tooltip: 'Request Now',
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        );
      },
    );
  }
}

