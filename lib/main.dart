import 'package:flutter/material.dart';
import 'package:maslindapp/src/pages/client/products/list/client_products_list_page.dart';
import 'package:maslindapp/src/pages/client/update/client_update_page.dart';
import 'package:maslindapp/src/pages/delivery/orders/list/delivery_orders_list_page.dart';
import 'package:maslindapp/src/pages/login/login_page.dart';
import 'package:maslindapp/src/pages/register/register_page.dart';
import 'package:maslindapp/src/pages/roles/roles_page.dart';
import 'package:maslindapp/src/pages/salon/categories/create/salon_categories_create_page.dart';
import 'package:maslindapp/src/pages/salon/orders/list/salon_orders_list_page.dart';
import 'package:maslindapp/src/pages/salon/products/create/salon_products_create_page.dart';
import 'package:maslindapp/src/utils/my_colors.dart';
import 'package:flutter/src/widgets/navigator.dart';

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
       'login' : (BuildContext context) => LoginPage(),
       'register' : (BuildContext context) => RegisterPage(),
       'roles' : (BuildContext context) => RolesPage(),
       'client/products/list' : (BuildContext context) => ClientProductsListPage(),
       'client/update' : (BuildContext context) => ClientUpdatePage(),
       'salon/orders/list' : (BuildContext context) => SalonOrdersListPage(),
       'salon/categories/create' : (BuildContext context) => SalonCategoriesCreatePage(),
       'salon/products/create' : (BuildContext context) => SalonProductsCreatePage(),
       'delivery/orders/list' : (BuildContext context) => DeliveryOrdersListPage()
     },
     theme: ThemeData(
       fontFamily: 'NimbusSans',
       colorScheme: ColorScheme.light(primary: MyColors.primaryColor)
     ),
    );
  }
}
