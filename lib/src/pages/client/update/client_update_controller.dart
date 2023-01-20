import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:maslindapp/src/models/response_api.dart';
import 'package:maslindapp/src/models/user.dart';
import 'package:maslindapp/src/provider/users_provider.dart';
import 'package:maslindapp/src/utils/my_snackbar.dart';
import 'package:maslindapp/src/utils/shared_pref.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';

class ClientUpdateController {
  BuildContext context;
  TextEditingController emailController =  new TextEditingController();
  TextEditingController nameController =  new TextEditingController();
  TextEditingController lastnameController =  new TextEditingController();
  TextEditingController phoneController =  new TextEditingController();

  UserProviders userProviders =  new UserProviders();
  PickedFile pickedFile;
  File imageFile;
  Function refresh;

  ProgressDialog _progressDialog;
  bool isEnable = true;
  User user;
  SharedPref _sharedPref =  new SharedPref();

  Future init(BuildContext context, Function refresh) async {
    this.context =  context;
    this.refresh = refresh;
    _progressDialog = ProgressDialog(context: context);
    user = User.fromJson(await _sharedPref.read('user'));
    print('TOKEN ENVIADO: ${user.sessionToken}');
    userProviders.init(context, sessionUser: user);


    nameController.text = user.name;
    lastnameController.text = user.lastname;
    phoneController.text = user.phone;
    refresh();
  }

  void update() async {
    String name =   nameController.text;
    String lastname =  lastnameController.text;
    String phone =  phoneController.text.trim();

    if( name.isEmpty || lastname.isEmpty || phone.isEmpty ){
      MySnackbar.show(context, 'Debes de ingresar todos los campos');
      return;
    }

    _progressDialog.show(
        max: 100,
        msg: 'Procesando...'
    );
    isEnable =  false;

    User myUser =  new User(
        id: user.id,
        name: name,
        lastname: lastname,
        phone: phone,
        image: user.image
    );
    Stream stream =  await userProviders.update(myUser, imageFile);
    if (stream != null) {
      stream.listen((res) async {
        _progressDialog.close();

        ResponseApi responseApi = ResponseApi.fromJson(json.decode(res));
        Fluttertoast.showToast(msg: responseApi.message);


        if (responseApi.success) {
          user = await userProviders.getById(
              myUser.id); // opteniendo el usuario de la base de datos
          print('Usuario obtenido: ${user.toJson()}');
          _sharedPref.save('user', user.toJson());
          Navigator.pushNamedAndRemoveUntil(
              context, 'client/products/list', (route) => false);
        }
        else {
          isEnable = true;
        }
      });
    }

  }
  Future selectImage(ImageSource imageSource) async {
    pickedFile =  await ImagePicker().getImage(source: imageSource);
    if (pickedFile != null) {
      imageFile = File(pickedFile.path);
    }
    Navigator.pop(context);
    refresh();
  }


  void showAlertDialog() {
    Widget galleryButton = ElevatedButton(
        onPressed: (){
          selectImage(ImageSource.gallery);
        },
        child: Text('GALERIA'));
    Widget camaraButton = ElevatedButton(
        onPressed: (){
          selectImage(ImageSource.camera);
        },
        child: Text('CAMARA'));
    AlertDialog alertDialog =  AlertDialog(
      title: Text('Selecciona tu imagen'),
      actions: [
        galleryButton,
        camaraButton
      ],
    );
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return alertDialog;
        }
    );
  }

  void back() {
    Navigator.pop(context);
  }

}