
import 'package:flutter/material.dart';
import 'package:maslindapp/src/models/user.dart';
import 'package:maslindapp/src/provider/address_provider.dart';
import 'package:maslindapp/src/utils/shared_pref.dart';

class ClientAppointmentCreateController {
  BuildContext context;
  Function refresh;

  TextEditingController descripcionController =  new TextEditingController();
  TextEditingController timeController =  new TextEditingController();

  AddressProvider _addressProvider =  new AddressProvider();
  User user;
  SharedPref sharedPref =  SharedPref();

}