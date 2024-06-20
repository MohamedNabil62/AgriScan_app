import 'package:agriscan/modules/user_modules/agriscan_cart/cuibt/state.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../models_user/cart_model.dart';
import '../../../../shared/components/constants.dart';
import '../../../../shared/network/remote/dio_helper.dart';
import '../cart_model.dart';

class CartCubit extends Cubit<CartStates> {
  CartCubit() :super(CartInitialState());
  static CartCubit get(context) => BlocProvider.of(context);
  bool unUser=false;
  bool Logindone=false;
  bool addtolist=false;
  List<BoradingModel>boradingg=[
  ];

  void rmove(@required int? x){
    //boradingg.removeWhere((item) => item.id == x);
    double doubleValue = double.parse(boradingg[x!].Price as String);
    double t=doubleValue * (boradingg[x].num as int?)! ;
    toprice -= t;
    boradingg.removeAt(x!);
  //  addtolist=false;
    emit(CartRemoveState());
  }
  void addList(){
    addtolist=true;
    emit(CartAddTOListState());
  }
  void addValueList(
      int? id,
      String? image,
      String? name,
      String? Price,
      int? num,
      double? to
      ){
    boradingg.add(
        BoradingModel(
          id: id,
          image: image,
          name: name,
          Price: Price,
          num: num,
          totalprice:to ,
        )
        );
    emit(CartAddValueListState());
  }
  void replaceValueList(
      int? id,
      String? image,
      String? name,
      String? Price,
      int? num,
      double? to
      ) {
    bool t=false;
    if(boradingg.isNotEmpty)
      {
    for (int i = 0; i < boradingg.length; i++) {
      if (boradingg[i].id == id) {
        boradingg[i].image = image;
        boradingg[i].name = name;
        boradingg[i].Price = Price;
        boradingg[i].num = num;
        boradingg[i].totalprice = to;
        t=true;
      }
    }
    if(t)
      {
        addValueList(id, image, name, Price, num, to);
      }}
    emit(CartReplaceValueListState());
  }

  double toprice=0;
  void totalPrice()
  {
    toprice=0;
    for(int x=0;x<boradingg.length;x++)
    {
      toprice +=boradingg[x].totalprice! ;
    }
    emit(CartTotalPriceState());
  }
  void add(
  @required int m,
      )
  {
    boradingg[m].num = boradingg[m].num!  + 1;
    double doubleValue = double.parse(boradingg[m].Price as String);
    toprice +=doubleValue;
    emit(CartAddState());
  }
  void minis(
      @required int m,
      )
  {
    if(boradingg[m].num!>1) {
      boradingg[m].num = boradingg[m].num! - 1;
      double doubleValue = double.parse(boradingg[m].Price as String);
      toprice -= doubleValue;
    }
    emit(CartMinisState());
  }
  Map<String, dynamic> myMap = {};
  List<Map<String, dynamic>> listcart = [];
  AgriScanCartModel? cartModel;
  bool pyment=false;
  bool done=true;
  bool Logout=false;
  bool Logoutchak=true;
  void userCart({
    required Map<String, dynamic> myMap,
    required List<Map<String, dynamic>> listcart,
    required String? value,
  }
      ){
    String tto='Bearer '+value!;
    print("this is token form loading${token}");
    print("this is token form loading ${tto}\n");
    emit(CartLoadingState());
    Diohelper.postData(
      url:  "/stripe-checkout",
      token:tto,
      data: {
        'shipping_address':myMap,
        'products':listcart,
      },
    ).then((value){
      // print(value?.data);
      cartModel=AgriScanCartModel.fromJson(value?.data);
      print(cartModel?.data?.paymentUrl);
      pyment=true;
      emit(CartSuccessState(cartModel!));
    }).catchError((error){
      print("this is token form error${token}");
      print(error.toString());
      emit(CartErrorState());
    });
  }
  int x=1;
  double total=0;
  void changePrisePlus()
  {
    x++;
    emit(AgriScanProductPlusState());
  }
  void changePriseMinis()
  {
    if(x>1)
      x--;
    emit(AgriScanProductMinisState());
  }
}
