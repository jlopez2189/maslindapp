import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:maslindapp/src/models/services.dart';
import 'package:maslindapp/src/models/stores.dart';
import 'package:maslindapp/src/models/user.dart';
import 'package:maslindapp/src/provider/services_provider.dart';
import 'package:maslindapp/src/utils/shared_pref.dart';


class ClientStoresDetailController {
  BuildContext context;
  Function refresh;

  Stores stores;
  int counter = 1;
  SharedPref _sharedPref =  new SharedPref();
  List<Stores> selectedStores = [];
  List<Services> services = [];
  String idServices;
  User user;
  ServicesProvider _servicesProvider =  new ServicesProvider();

  Future init(BuildContext context, Function refresh, Stores stores) async {

    this.context =  context;
    this.refresh =  refresh;
    this.stores =  stores;
    _servicesProvider.init(context, user);

    selectedStores = Stores.fromJsonList(await _sharedPref.read('order')).toList;
    selectedStores.forEach((p) {
      print('Tienda seleccionada: ${p.toJson()}');
         }
    );
    refresh();

    void addToBag() {
      int index = selectedStores.indexWhere((p) => p.id == stores.id);
      if (index == -1) {
        if (stores.condition == null) {
          stores.condition = 0;
        }
        selectedStores.add(stores);
      }
      _sharedPref.save('order', selectedStores);
      Fluttertoast.showToast(msg: 'Tienda Agregada');
    }
    getServices();
  }

  /// llamado de la combobok categorias
  void getServices() async {
    services = await _servicesProvider.getAll();
    refresh();
  }
  void close() {
    Navigator.pop(context);
  }


}