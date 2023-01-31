import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:maslindapp/src/models/category.dart';
import 'package:maslindapp/src/models/response_api.dart';
import 'package:maslindapp/src/models/stores.dart';
import 'package:maslindapp/src/models/user.dart';
import 'package:maslindapp/src/provider/categories_provider.dart';
import 'package:maslindapp/src/provider/stores_provider.dart';
import 'package:maslindapp/src/utils/my_snackbar.dart';
import 'package:maslindapp/src/utils/shared_pref.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';

class SalonStoresCreateController {

  BuildContext context;
  Function refresh;

  TextEditingController shopController =  new TextEditingController();
  TextEditingController descripcionController =  new TextEditingController();
  StoresProvider _storesProvider =  StoresProvider();
  CategoriesProvider _categoriesProvider =  new CategoriesProvider();
  User user;
  SharedPref sharedPref =  SharedPref();
  List<Category> categories = [];

  String idCategory;
  /// IMAGENES
  PickedFile pickedFile;
  File imageFile1;
  File imageFile2;
  File imageFile3;

  ProgressDialog _progressDialog;

  Future ini(BuildContext context, Function refresh) async {
    this.context =  context;
    this.refresh =  refresh;
    _progressDialog = new ProgressDialog(context: context);
    user = User.fromJson(await sharedPref.read('user'));
    _storesProvider.init(context, user);
    _categoriesProvider.init(context, user);
    getCategories();
  }

  /// llamado de la combobok categorias
  void getCategories() async {
    categories = await _categoriesProvider.getAll();
    refresh();
  }


  void createStore() async {
    String name = shopController.text;
    String descripcion =  descripcionController.text;

    if (name.isEmpty || descripcion.isEmpty) {
      MySnackbar.show(context, 'Debe ingresar todos los campos');
      return;
    }
    if (imageFile1 == null || imageFile2 == null || imageFile3 == null) {
      MySnackbar.show(context, 'Selecciona las 3 imagenes');
      return;
    }

    //validacion de catalogo de categorias
    if (idCategory == null) {
      MySnackbar.show(context, 'Selecciona una categoria para el producto');
      return;
    }


    Stores stores = new Stores(
        shop: name,
        description: descripcion,
        idCategory: int.parse(idCategory)
    );

    List<File> images = [];
    images.add(imageFile1);
    images.add(imageFile2);
    images.add(imageFile3);

    // mensajes //

    Stream stream = await _storesProvider.create(stores, images);
    stream.listen((res) {
    _progressDialog.close();
    ResponseApi responseApi = ResponseApi.fromJson(json.decode(res));
    print('Respuesta: ${responseApi.toJson()}');
    MySnackbar.show(context, responseApi.message);

      if (responseApi.success) {
        ///resetValues();
        shopController.text = '';
        descripcionController.text = '';
        imageFile1 = null;
        imageFile2 = null;
        imageFile3 = null;
        idCategory = null;
        refresh();
      }
    });
    print('Formulario Tienda: ${stores.toJson()}');
  }

  void resetValues() {
    shopController.text = '';
    descripcionController.text = '';
    imageFile1 = null;
    imageFile2 = null;
    imageFile3 = null;
    idCategory = null;
    refresh();
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