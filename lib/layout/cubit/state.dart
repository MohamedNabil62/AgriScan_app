
import 'package:agriscan/models/changeFavoritesmodelPOST.dart';
import 'package:agriscan/models/profile_model.dart';

abstract class AgriScanStates{}

class AgriScanInitialState extends AgriScanStates{}

class AgriScanChangeBottomNavState extends AgriScanStates{}

//Profile
class AgriscanGetProfileImageSuccessState extends AgriScanStates{}

class AgriScanGetProfileImageErrorState extends AgriScanStates{}