import 'package:flutter/material.dart';


class ClientAddressMapController {
  BuildContext context;
  Function refresh;

  ///Position _position;

  String addressName;

  //Latlng


  Future init(BuildContext context, Function refresh) {
    this.context = context;
    this.refresh = refresh;
  }
}
