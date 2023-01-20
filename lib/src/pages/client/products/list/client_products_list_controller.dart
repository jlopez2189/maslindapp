import 'package:flutter/material.dart';
import 'package:maslindapp/src/models/user.dart';
import 'package:maslindapp/src/utils/shared_pref.dart';
class ClientProductsListController {
  BuildContext context;
  SharedPref _sharedPref =  new SharedPref();
  GlobalKey<ScaffoldState> key = new GlobalKey<ScaffoldState>();
  Function refresh;
  User user;

  Future init(BuildContext context, Function refresh ) async {
    this.context =  context;
    this.refresh =  refresh;
    user = User.fromJson(await _sharedPref.read('user'));
    refresh();
  }

 void logout() {
    _sharedPref.logout(context, user.id);
  }

  void openDrawer() {
   key.currentState.openDrawer();
  }

  void goToUpdatePage() {
    Navigator.pushNamed(context, 'client/update');
  }
  
  void gotoRoles() {
    Navigator.pushNamedAndRemoveUntil(context, 'roles', (route) => false);
  }


}