import 'package:flutter/material.dart';
import 'package:maslindapp/src/models/user.dart';
import 'package:maslindapp/src/utils/shared_pref.dart';
class RolesController {
  BuildContext context;
  Function refresh;
  User user;
  SharedPref sharedPref = new SharedPref();

  Future init(BuildContext context, Function refresh) async {
    this.context =  context;
    this.refresh = refresh;

    // opteniendo el usuario de session
    user = User.fromJson( await sharedPref.read('user'));
    refresh();
  }
  
  void gotoPage(String route) {
    Navigator.pushNamedAndRemoveUntil(context, route , (route) => false);
  }
  
}