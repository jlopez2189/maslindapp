import 'package:flutter/material.dart';
import 'package:maslindapp/src/models/response_api.dart';
import 'package:maslindapp/src/models/user.dart';
import 'package:maslindapp/src/provider/categories_provider.dart';
import 'package:maslindapp/src/utils/my_snackbar.dart';
import 'package:maslindapp/src/utils/shared_pref.dart';
import 'package:maslindapp/src/models/category.dart';


class SalonCategoriesCreateController {

  BuildContext context;
  Function refresh;

  TextEditingController nameController =  new TextEditingController();
  TextEditingController descripcionController =  new TextEditingController();

  CategoriesProvider _categoriesProvider =  CategoriesProvider();
  User user;
  SharedPref sharedPref =  SharedPref();

  Future ini(BuildContext context, Function refresh) async {
    this.context =  context;
    this.refresh =  refresh;
    user = User.fromJson(await sharedPref.read('user'));
    _categoriesProvider.init(context, user);
  }

  void createCategoria() async {
    String name = nameController.text;
    String descripcion =  descripcionController.text;
    if (name.isEmpty || descripcion.isEmpty) {
      MySnackbar.show(context, 'Debe ingresar todos los campos');
      return;
    }
     Category category =  new Category(
       name: name,
       description: descripcion
     );

    ResponseApi responseApi =  await _categoriesProvider.create(category);
    
    MySnackbar.show(context, responseApi.message);
    
    if (responseApi.success) {
      nameController.text = '';
      descripcionController.text = '';
    }
    ///print('Nombre: ${name}');
   /// print('Descripcion: ${descripcion}');

  }


}