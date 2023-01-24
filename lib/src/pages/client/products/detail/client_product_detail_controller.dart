import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:maslindapp/src/models/product.dart';
import 'package:maslindapp/src/utils/shared_pref.dart';

class ClientProductDetailController {
  BuildContext context;
  Function refresh;

  Product product;
  int counter = 1;
  double productPrice;
  SharedPref _sharedPref =  new SharedPref();
  List<Product> selectedProducts = [];

  Future init(BuildContext context, Function refresh, Product product) async {
    this.context =  context;
    this.refresh =  refresh;
    this.product =  product;
    productPrice = product.precio;

    //_sharedPref.remove('order');

    selectedProducts = Product.fromJsonList(await _sharedPref.read('order')).toList;
    selectedProducts.forEach((p) {
      print('Producto seleccionado: ${p.toJson()}');
    });
    refresh();
  }

  void addToBag() {
    int index = selectedProducts.indexWhere((p) => p.id == product.id);
    if (index == -1) { // productos seleccionados no existe ese producto
     if (product.quantity == null) {
       product.quantity = 1;
     }
     selectedProducts.add(product);
    }
    else
      {
        selectedProducts[index].quantity = counter;
      }
    _sharedPref.save('order', selectedProducts);
    Fluttertoast.showToast(msg: 'Producto Agregado');
  }

  void addItem() {
    counter =  counter + 1;
    productPrice = product.precio * counter;
    product.quantity = counter;
    refresh();
  }


  void removeItem() {

    if (counter > 1) {
      counter =  counter - 1;
      productPrice = product.precio * counter;
      product.quantity = counter;
      refresh();
    }

  }

  void close() {
    Navigator.pop(context);
  }


}