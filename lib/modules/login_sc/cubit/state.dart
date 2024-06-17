


import 'package:agriscan/models/login_model.dart';

abstract class AgriScanLoginStates{}

class  AgriScanLoginInitialState extends AgriScanLoginStates{}

class  AgriScanLoginLoadingState extends AgriScanLoginStates{}

class  AgriScanLoginSuccessState extends AgriScanLoginStates{
   final AgriScanLoginModel LoginModel;

  AgriScanLoginSuccessState(this.LoginModel);
}

class  AgriScanLoginErrorState extends AgriScanLoginStates{

  final String error;
  AgriScanLoginErrorState(this.error);
}

class  AgriScanchangePasswordVisibilityState extends AgriScanLoginStates{}