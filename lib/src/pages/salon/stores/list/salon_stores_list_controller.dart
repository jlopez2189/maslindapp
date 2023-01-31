import 'package:flutter/material.dart';
import 'package:maslindapp/src/models/category.dart';
import 'package:maslindapp/src/models/stores.dart';
import 'package:maslindapp/src/models/user.dart';
import 'package:maslindapp/src/provider/categories_provider.dart';
import 'package:maslindapp/src/provider/stores_provider.dart';
import 'package:maslindapp/src/utils/shared_pref.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class SalonStoresListController {
BuildContext context;
SharedPref _sharedPref =  new SharedPref();
GlobalKey<ScaffoldState> key = new GlobalKey<ScaffoldState>();
Function refresh;
User user;

CategoriesProvider _categoriesProvider = new CategoriesProvider();
StoresProvider _storesProvider =  new StoresProvider();

List<Category> categories = [];

void getCategories() async {
  categories =  await _categoriesProvider.getAll();
  refresh();
}

Future init(BuildContext context, Function refresh ) async {
  this.context =  context;
  this.refresh =  refresh;
  user = User.fromJson(await _sharedPref.read('user'));
  _categoriesProvider.init(context, user);
  _storesProvider.init(context, user);
  getCategories();
  refresh();
}

Future<List<Stores>> getStores(String idCategory) async {
  return await _storesProvider.getByCategory(idCategory);
}

void openBottonSheet(Stores stores) {
  showMaterialModalBottomSheet(
      context: context,
      ///builder: (context) => ClientProductDetailPage(product: stores)
  );
}


void logout() {
  _sharedPref.logout(context, user.id);
}

void openDrawer() {
  key.currentState.openDrawer();
}

void goToCreateStores() {
  Navigator.pushNamed(context, 'salon/stores/create');
}

void goToStores() {
  Navigator.pushNamed(context, 'client/stores/list');
}

void gotoRoles() {
  Navigator.pushNamedAndRemoveUntil(context, 'roles', (route) => false);
}


}