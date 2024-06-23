
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

//list eng

class AgriScanStateErrorListEng extends AgriScanStates{

  final String error;
  AgriScanStateErrorListEng(this.error);
}

class AgriScanStateLoadingListEng extends AgriScanStates{}

class AgriScanStateSuccessListEng extends AgriScanStates{}

//time

class AgriScanStateErrorTimeUser extends AgriScanStates{

  final String error;
  AgriScanStateErrorTimeUser(this.error);
}

class AgriScanStateLoadingTimeUser extends AgriScanStates{}

class AgriScanStateSuccessTimeUser extends AgriScanStates{}

//create meeting

class AgriScanStateErrorCreat extends AgriScanStates{

  final String error;
  AgriScanStateErrorCreat(this.error);
}

class AgriScanStateLoadingCreat extends AgriScanStates{}

class AgriScanStateSuccessCreat extends AgriScanStates{}

//plant

class AgriScanStateErrorPlantData extends AgriScanStates{

  final String error;
  AgriScanStateErrorPlantData(this.error);
}

class AgriScanStateLoadingPlantData extends AgriScanStates{}

class AgriScanStateSuccessPlantData extends AgriScanStates{}

//prodect

class AgriScanStateErrorProdecttData extends AgriScanStates{

  final String error;
  AgriScanStateErrorProdecttData(this.error);
}

class AgriScanStateLoadingProdecttData extends AgriScanStates{}

class AgriScanStateSuccessProdecttData extends AgriScanStates{}

//order
class AgriScanStateErrorOrder extends AgriScanStates{

  final String error;
  AgriScanStateErrorOrder(this.error);
}

class AgriScanStateLoadingOrder extends AgriScanStates{}

class AgriScanStateSuccessOrder extends AgriScanStates{}

//upcoming meeting user
class AgriScanStateErrorComingMeetingUser extends AgriScanStates{

  final String error;
  AgriScanStateErrorComingMeetingUser(this.error);
}

class AgriScanStateLoadingComingMeetingUser extends AgriScanStates{}

class AgriScanStateSuccessComingMeetingUser extends AgriScanStates{}
//logout
class AgriScanLogoutErrorState extends AgriScanStates{

  final String error;
  AgriScanLogoutErrorState(this.error);
}

class AgriScanLogoutLoadingState extends AgriScanStates{}

class AgriScanLogoutSuccessState extends AgriScanStates{}
//rate
class AgriScanRateErrorState extends AgriScanStates{

  final String error;
  AgriScanRateErrorState(this.error);
}

class AgriScanRateLoadingState extends AgriScanStates{}

class AgriScanRateSuccessState extends AgriScanStates{}