
import 'package:agriscan/models/profile_model.dart';

abstract class AgriScanStates{}

class AgriScanInitialState extends AgriScanStates{}

class AgriScanChangeBottomNavState extends AgriScanStates{}

//Profile
class AgriscanGetProfileImageSuccessState extends AgriScanStates{}

class AgriScanGetProfileImageErrorState extends AgriScanStates{}

//add time
class AppChangeBottomSheetState extends AgriScanStates{}

// get data
class AgriScanErrorUserDataState extends AgriScanStates{

  final String error;
  AgriScanErrorUserDataState(this.error);
}

class AgriScanLoadingUserDataState extends AgriScanStates{}

class AgriScanSuccessUserDataState extends AgriScanStates{}

//Update

class AgriScanErrorUpdateUserDataState extends AgriScanStates{

  final String error;
  AgriScanErrorUpdateUserDataState(this.error);
}

class AgriScanLoadingUpdateUserDataState extends AgriScanStates{}

class AgriScanSuccessUpdateUserDataState extends AgriScanStates{}
