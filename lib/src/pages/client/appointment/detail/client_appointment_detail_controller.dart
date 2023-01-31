import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:maslindapp/src/models/appointment.dart';
import 'package:maslindapp/src/models/services.dart';
import 'package:maslindapp/src/models/stores.dart';
import 'package:maslindapp/src/provider/services_provider.dart';
import 'package:maslindapp/src/utils/shared_pref.dart';

class ClientAppointmentDetailController {
  BuildContext context;
  Function refresh;

  ServicesProvider _servicesProvider =  new ServicesProvider();
  Stores stores;
  Appointment appointment;

  int counter = 1;
  SharedPref _sharedPref =  new SharedPref();
  List<Services> services = [];
  String idServices;




  Future init(BuildContext context, Function refresh, Stores stores, Appointment appointment ) async {
    this.context =  context;
    this.refresh =  refresh;
    this.stores =  stores;
    this.appointment = appointment;

    services = Services.fromJson(await _sharedPref.read('order')).toList;
    services.forEach((p) {
      print('Tienda seleccionada: ${p.toJson()}');
    });
    refresh();
  }

  void getServices() async {
    services = await _servicesProvider.getAll();
    refresh();
  }


  void addToBag() {
    int index = services.indexWhere((p) => p.id == stores.id);
    if (index == -1) { // productos seleccionados no existe ese producto
  //    services.add(services);
    }
     _sharedPref.save('order', services);
    Fluttertoast.showToast(msg: 'Cita Agregada');
  }

  void removeItem() {

    if (counter > 1) {
      counter =  counter - 1;
      refresh();
    }

  }

  void addItem() {
    counter =  counter + 1;
    //productPrice = product.precio * counter;
    ///product.quantity = counter;
    refresh();
  }

  void close() {
    Navigator.pop(context);
  }

}