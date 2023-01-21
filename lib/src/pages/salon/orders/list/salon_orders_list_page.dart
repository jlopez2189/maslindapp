import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:maslindapp/src/pages/client/products/list/client_products_list_controller.dart';
import 'package:maslindapp/src/pages/salon/orders/list/salon_orders_list_controller.dart';
class SalonOrdersListPage extends StatefulWidget {
  const SalonOrdersListPage({Key key}) : super(key: key);

  @override
  _SalonOrdersListPageState createState() => _SalonOrdersListPageState();
}

class _SalonOrdersListPageState extends State<SalonOrdersListPage> {

  SalonOrdersListController _con =  new SalonOrdersListController();
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
      key: _con.key,
      appBar: AppBar(
        leading: _menudrawer(),
      ),
      drawer: _drawer(),
      body: Center(
        child: Text('Salon lista de ordenes'),
      ),
    );
  }
  Widget _menudrawer() {
    return GestureDetector(
      onTap: _con.openDrawer,
      child: Container(
        margin: EdgeInsets.only(left: 20) ,
        alignment: Alignment.centerLeft,
        child: Image.asset('assets/img/menuredondeado.png', width: 20, height: 20),
      ),
    );
  }
  Widget _drawer() {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
              decoration: BoxDecoration(
                  color: Colors.black54
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${_con.user?.name ?? ''} ${_con.user?.lastname ?? ''}',
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.bold
                    ),
                    maxLines: 1,
                  ),
                  Text(
                    _con.user?.email ?? '',
                    style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey[200],
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic
                    ),
                    maxLines: 1,
                  ),
                  Text(
                    _con.user?.phone ?? '',
                    style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey[200],
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic
                    ),
                    maxLines: 1,
                  ),
                  Container(
                    height: 60,
                    margin: EdgeInsets.only(top: 10),
                    child: FadeInImage(
                      image: _con.user?.image != null
                          ? NetworkImage(_con.user?.image)
                          :AssetImage('assets/img/no-image.png'),
                      fit: BoxFit.contain,
                      fadeInDuration: Duration(milliseconds: 50),
                      placeholder: AssetImage('assets/img/no-image.png'),
                    ),
                  )
                ],
              )
          ),
          ListTile(
            onTap: _con.gotoCategoriesCreate,
            title: Text('Crear Categoria'),
            trailing: Icon(Icons.list_alt),
          ),
          ListTile(
            onTap: _con.gotoProductsCreate,
            title: Text('Crear Producto'),
            trailing: Icon(Icons.production_quantity_limits),
          ),
          _con.user != null ?
          _con.user.roles.length > 1 ?
          ListTile(
            onTap: _con.gotoRoles,
            title: Text('Seleccionar rol'),
            trailing: Icon(Icons.person_outline),
          ) : Container() :Container(),
          ListTile(
            onTap: _con.logout,
            title: Text('Cerrar session'),
            trailing: Icon(Icons.power_settings_new),
          ),

        ],
      ),
    );
  }

  void refresh() {
    setState(() {});
  }

}
