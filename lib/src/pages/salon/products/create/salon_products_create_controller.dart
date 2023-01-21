import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:image_picker/image_picker.dart';
import 'package:maslindapp/src/models/user.dart';
import 'package:maslindapp/src/provider/categories_provider.dart';
import 'package:maslindapp/src/utils/my_snackbar.dart';
import 'package:maslindapp/src/utils/shared_pref.dart';
import 'package:maslindapp/src/models/category.dart';


class SalonProductsCreateController {

  BuildContext context;
  Function refresh;

  TextEditingController nameController =  new TextEditingController();
  TextEditingController descripcionController =  new TextEditingController();
  MoneyMaskedTextController precioController = new MoneyMaskedTextController();
  CategoriesProvider _categoriesProvider =  CategoriesProvider();
  User user;
  SharedPref sharedPref =  SharedPref();
  List<Category> categories = [];
  String idCategory; // almacena el id de la categoria seleccionada
  /// IMAGENES
  PickedFile pickedFile;
  File imageFile1;
  File imageFile2;
  File imageFile3;



  Future ini(BuildContext context, Function refresh) async {
    this.context =  context;
    this.refresh =  refresh;
    user = User.fromJson(await sharedPref.read('user'));
    _categoriesProvider.init(context, user);
    getCategories();
  }
  /// llamado de la combobok categorias
  void getCategories() async {
   categories = await _categoriesProvider.getAll();
   refresh();
  }

  void createProduct() async {
    String name = nameController.text;
    String descripcion =  descripcionController.text;
    double precio =  precioController.numberValue;

    if (name.isEmpty || descripcion.isEmpty || precio == 0 ) {
      MySnackbar.show(context, 'Debe ingresar todos los campos');
      return;
    }
    if (imageFile1 == null || imageFile2 == null || imageFile3 == null) {
      MySnackbar.show(context, 'Selecciona las 3 imagenes');
      return;
    }

    if (idCategory == null) {
      MySnackbar.show(context, 'Selecciona una categoria para el producto');
      return;
    }



  }

  Future selectImage(ImageSource imageSource, int numberFile) async {
    pickedFile =  await ImagePicker().getImage(source: imageSource);
    if (pickedFile != null) {
      if (numberFile == 1) {
        imageFile1 = File(pickedFile.path);
      }
      else if (numberFile == 2) {
        imageFile2 = File(pickedFile.path);
      }
      else if (numberFile == 3) {
        imageFile3 = File(pickedFile.path);
      }

    }
    Navigator.pop(context);
    refresh();
  }

  void showAlertDialog(int numberFile) {
    Widget galleryButton = ElevatedButton(
        onPressed: (){
          selectImage(ImageSource.gallery, numberFile);
        },
        child: Text('GALERIA'));
    Widget camaraButton = ElevatedButton(
        onPressed: (){
          selectImage(ImageSource.camera, numberFile);
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


}