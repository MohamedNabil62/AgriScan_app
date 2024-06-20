
import '../../../../models_user/cart_model.dart';

abstract class CartStates{}

class CartInitialState extends CartStates{}

class CartRemoveState extends CartStates{}

class CartAddTOListState extends CartStates{}

class CartAddValueListState extends CartStates{}

class CartReplaceValueListState extends CartStates{}

class CartTotalPriceState extends CartStates{}

class CartAddState extends CartStates{}

class CartMinisState extends CartStates{}

class CartLoadingState extends CartStates{}

class CartSuccessState extends CartStates{
  final AgriScanCartModel cartModel;
  CartSuccessState(this.cartModel);
}

class CartErrorState extends CartStates{}

//
class AgriScanProductPlusState extends CartStates{}
class AgriScanProductMinisState extends CartStates{}