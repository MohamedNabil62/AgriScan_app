
import 'package:agriscan/models/profile_model.dart';

abstract class EngAgriScanStates{}

class EngAgriScanInitialState extends EngAgriScanStates{}

//get time
class EngAgriScanStateSuccessGetAvailableAppointments extends EngAgriScanStates{}

class EngAgriScanStateLoadingGetAvailableAppointments extends EngAgriScanStates{}

class EngAgriScanStateErrorGetAvailableAppointments extends EngAgriScanStates{

  final String error;
  EngAgriScanStateErrorGetAvailableAppointments(this.error);

}

//setTime
class EngAgriScanStateSuccessSetAppointments extends EngAgriScanStates{}

class EngAgriScanStateLoadingSetAppointments extends EngAgriScanStates{}

class EngAgriScanStateErrorSetAppointments extends EngAgriScanStates{

  final String error;
  EngAgriScanStateErrorSetAppointments(this.error);

}

class AppChangeBottomSheetStateEng extends EngAgriScanStates{}

//upcoming
class EngAgriScanStateSuccessUpComingMeeting extends EngAgriScanStates{}

class EngAgriScanStateLoadingUpComingMeeting extends EngAgriScanStates{}

class EngAgriScanStateErrorUpComingMeeting extends EngAgriScanStates{

  final String error;
  EngAgriScanStateErrorUpComingMeeting(this.error);

}

//amount

class EngAgriScanStateSuccessAmount extends EngAgriScanStates{}

class EngAgriScanStateLoadingAmount  extends EngAgriScanStates{}

class EngAgriScanStateErrorAmount  extends EngAgriScanStates{

  final String error;
  EngAgriScanStateErrorAmount (this.error);

}

//new rq

class EngAgriScanStateSuccessNewR extends EngAgriScanStates{}

class EngAgriScanStateLoadingNewR  extends EngAgriScanStates{}

class EngAgriScanStateErrorNewR  extends EngAgriScanStates{

  final String error;
  EngAgriScanStateErrorNewR (this.error);

}
