import 'package:flutter/material.dart';
import 'package:maslindapp/src/pages/client/address/create/client_address_create_page.dart';
import 'package:maslindapp/src/pages/client/address/list/client_address_list_page.dart';
import 'package:maslindapp/src/pages/client/address/map/client_address_map_page.dart';
import 'package:maslindapp/src/pages/client/orders/create/client_order_create_page.dart';
import 'package:maslindapp/src/pages/client/products/list/client_products_list_page.dart';
import 'package:maslindapp/src/pages/client/update/client_update_page.dart';
import 'package:maslindapp/src/pages/delivery/orders/list/delivery_orders_list_page.dart';
import 'package:maslindapp/src/pages/login/login_page.dart';
import 'package:maslindapp/src/pages/login/splash_screen.dart';
import 'package:maslindapp/src/pages/register/register_page.dart';
import 'package:maslindapp/src/pages/roles/roles_page.dart';
import 'package:maslindapp/src/pages/salon/categories/create/salon_categories_create_page.dart';
import 'package:maslindapp/src/pages/salon/orders/list/salon_orders_list_page.dart';
import 'package:maslindapp/src/pages/salon/products/create/salon_products_create_page.dart';
import 'package:maslindapp/src/pages/salon/stores/create/salon_stores_create_page.dart';
import 'package:maslindapp/src/utils/my_colors.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp ({Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
     title: 'App salon mas linda',
     debugShowCheckedModeBanner: false,
     initialRoute: 'login',
     routes: {
       ///'login' : (BuildContext context) => LoginPage(),
       'login' : (BuildContext context) => SplashScreen(),
       'register' : (BuildContext context) => RegisterPage(),
       'roles' : (BuildContext context) => RolesPage(),
       'client/products/list' : (BuildContext context) => ClientProductsListPage(),
       'client/update' : (BuildContext context) => ClientUpdatePage(),
       'client/orders/create' : (BuildContext context) => ClientOrdersCreatePage(),
       'client/address/list' : (BuildContext context) => ClientAddressListPage(),
       'client/address/create' : (BuildContext context) => ClientAddressCreatePage(),
       'client/address/map' : (BuildContext context) => ClientAddressMapPage(),
       'salon/orders/list' : (BuildContext context) => SalonOrdersListPage(),
       'salon/categories/create' : (BuildContext context) => SalonCategoriesCreatePage(),
       'salon/stores/create' : (BuildContext context) => SalonStoresCreatePage(),
       'salon/products/create' : (BuildContext context) => SalonProductsCreatePage(),
       'delivery/orders/list' : (BuildContext context) => DeliveryOrdersListPage()
     },
     theme: ThemeData(
       fontFamily: 'NimbusSans',
       colorScheme: ColorScheme.light(primary: MyColors.primaryColor),
       appBarTheme: AppBarTheme(elevation: 0 )
     ),
    );
  }
}
