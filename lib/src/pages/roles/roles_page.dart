import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:maslindapp/src/models/rol.dart';
import 'package:maslindapp/src/pages/roles/roles_controller.dart';


class RolesPage extends StatefulWidget {
  const RolesPage({Key key}) : super(key: key);

  @override
  _RolesPageState createState() => _RolesPageState();
}

class _RolesPageState extends State<RolesPage> {

  RolesController _con = new RolesController();
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
    return  Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor:Color(0xff6E0643),
        title: Text(
          'Selecciona un Rol',
           style: TextStyle(
             //color: Colors.black,
             color:  Color(0xffEEEEEE),
             fontWeight: FontWeight.bold,
             fontSize: 18,
           ),
        ),
      ),
      body: Container(
        // Centralizacion de las imagenes de los roles
        margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.05),
        child: ListView(
          children:
            _con.user != null ? _con.user.roles.map((Rol rol) {
            return _cardRol(rol);
            }).toList(): []
          ),
      ),
    );
  }
  Widget _cardRol(Rol rol) {
   return GestureDetector(
     onTap: () {
       _con.gotoPage(rol.route);
     },
     child: Column(
        children: [
         Container(
           height: 120,
            child: FadeInImage(
            image: rol.image != null ? NetworkImage(rol.image)
                                      : AssetImage('assets/img/no-image.png'),
             fit: BoxFit.contain,
             fadeInDuration: Duration(milliseconds: 50),
             placeholder: AssetImage('assets/img/no-image.png'),
            ),
         ),
         SizedBox(height: 25),
         Text(
           rol.name ?? '',
           style: TextStyle(
             fontSize: 17,
             fontFamily: 'Roboto',
             color: Color(0xff6E0643),
           ),
         ),
         SizedBox(height: 25),
       ],
     ),
   );
  }

  void refresh() {
    setState(() {});
  }

}
