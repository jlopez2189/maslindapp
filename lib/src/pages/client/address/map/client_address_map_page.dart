import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:maslindapp/src/pages/client/address/list/client_address_list_controller.dart';
import 'package:maslindapp/src/pages/client/address/map/client_address_map_controller.dart';

class ClientAddressMapPage  extends StatefulWidget {
  const ClientAddressMapPage ({Key key}) : super(key: key);

  @override
  _ClientAddressMapPageState createState() => _ClientAddressMapPageState();
}

class _ClientAddressMapPageState extends State<ClientAddressMapPage> {

  ClientAddressMapController _con =  new ClientAddressMapController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
     _con.init(context, refresh);
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ubica tu direccion en el mapa'),
      ),

    );
  }

  void refresh() {
    setState(() {

    });
  }

}
