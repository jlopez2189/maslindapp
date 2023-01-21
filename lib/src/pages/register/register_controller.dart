import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:maslindapp/src/models/response_api.dart';
import 'package:maslindapp/src/models/user.dart';
import 'package:maslindapp/src/provider/users_provider.dart';
import 'package:maslindapp/src/utils/my_snackbar.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';
class RegisterController {
  BuildContext context;
  TextEditingController emailController =  new TextEditingController();
  TextEditingController nameController =  new TextEditingController();
  TextEditingController lastnameController =  new TextEditingController();
  TextEditingController phoneController =  new TextEditingController();
  TextEditingController passController =  new TextEditingController();
  TextEditingController confirmpassController =  new TextEditingController();

  UserProviders userProviders =  new UserProviders();
  PickedFile pickedFile;
  File imageFile;
  Function refresh;

  ProgressDialog _progressDialog;
  bool isEnable = true;

  Future init(BuildContext context, Function refresh) {
    this.context =  context;
    this.refresh = refresh;
    userProviders.init(context);
    _progressDialog = ProgressDialog(context: context);
  }

  void register() async {
    String email =  emailController.text.trim();
    String name =   nameController.text;
    String lastname =  lastnameController.text;
    String phone =  phoneController.text.trim();
    String password =  passController.text.trim();
    String confirmpassword =  confirmpassController.text.trim();

    if(email.isEmpty || name.isEmpty || lastname.isEmpty || phone.isEmpty || password.isEmpty || confirmpassword.isEmpty){
      MySnackbar.show(context, 'Debes de ingresar todos los campos');
      return;
    }

    if(confirmpassword != password) {
      MySnackbar.show(context, 'Los Passwords no coinciden');
      return;
    }

    if(password.length < 6) {
      MySnackbar.show(context, 'Los Passwords deben de tener al menos 6 caracteres');
      return;
    }

    if (imageFile == null) {
      MySnackbar.show(context, 'Selecciona una imagen');
      return;
    }

    _progressDialog.show(
        max: 100,
        msg: 'Procesando...'
    );
    isEnable =  false;

    User user =  new User(
      email: email,
      name: name,
      lastname: lastname,
      phone: phone,
      password: password
    );
    Stream stream =  await userProviders.createWithImage(user, imageFile);
    stream.listen((res) {
      _progressDialog.close();

      //ResponseApi responseApi = await userProviders.create(user);
      ResponseApi responseApi = ResponseApi.fromJson(json.decode(res));
      print('Respuesta: ${responseApi.toJson()}');
      MySnackbar.show(context, responseApi.message);

      if(responseApi.success) {
        Future.delayed(Duration(seconds: 3), (){
          Navigator.pushReplacementNamed(context, 'login');
        });
      }
      else
        {
          isEnable =  true;
        }

    });

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