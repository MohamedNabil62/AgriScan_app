

import 'package:agriscan/models/register_model.dart';



abstract class AgriScanRegisterStates{}

class  AgriScanRegisterInitialState extends AgriScanRegisterStates{}

class  AgriScanRegisterLoadingState extends AgriScanRegisterStates{}

class  AgriScanRegisterSuccessState extends AgriScanRegisterStates{
   final AgriScanRegistrModel RegisterModel;

  AgriScanRegisterSuccessState(this.RegisterModel);
}

class  AgriScanRegisterErrorState extends AgriScanRegisterStates{

  final String error;
  AgriScanRegisterErrorState(this.error);
}

class  AgriScanRegisterchangePasswordVisibilityState extends AgriScanRegisterStates{}