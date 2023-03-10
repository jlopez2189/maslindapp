import 'package:flutter/material.dart';
import 'package:maslindapp/src/models/response_api.dart';
import 'package:maslindapp/src/models/user.dart';
import 'package:maslindapp/src/provider/users_provider.dart';
import 'package:maslindapp/src/utils/my_snackbar.dart';
import 'package:maslindapp/src/utils/shared_pref.dart';
class LoginController {

  BuildContext context;
  TextEditingController emailController =  new TextEditingController();
  TextEditingController passController =  new TextEditingController();

  UserProviders usersProvider = new UserProviders();
  SharedPref _sharedPref =  new SharedPref();

  Future init(BuildContext context) async{
    this.context =  context;
    await usersProvider.init(context);

    User user = User.fromJson(await _sharedPref.read('user') ?? {});

    print('Usuario: ${user.toJson()}');

    // para iniciar session ya en la pantalla de producto eso solo si el usuario ya habia iniciado session anteiormente
    if(user?.sessionToken != null) {
      if (user.roles.length > 1) {
        Navigator.pushNamedAndRemoveUntil(
            context,'roles', (route) => false);
      }
      else
      {
        Navigator.pushNamedAndRemoveUntil(
            context,user.roles[0].route, (route) => false);
      }
    }
  }

  void  gotoRegisterPage() {
    Navigator.pushNamed(context, 'register');
  }
  void login() async{
    String email =  emailController.text.trim();
    String password =  passController.text.trim();
    ResponseApi responseApi =  await usersProvider.login(email, password);
    print('Respuesta object: ${responseApi}');
    print('Respuesta: ${responseApi.toJson()}');

    if(responseApi.success){
     User user = User.fromJson(responseApi.data);
     _sharedPref.save('user', user.toJson());
     
     print('USUARIO LOGEADO: ${user.toJson()}');
     if (user.roles.length > 1) {
       Navigator.pushNamedAndRemoveUntil(
       context,'roles', (route) => false);
     }
     else
       {
         Navigator.pushNamedAndRemoveUntil(
         context,user.roles[0].route, (route) => false);
       }
    }
    else
      {
        MySnackbar.show(context, responseApi.message);
      }





  }


}