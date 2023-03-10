import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:maslindapp/src/pages/client/update/client_update_controller.dart';
import 'package:maslindapp/src/pages/register/register_controller.dart';
import 'package:maslindapp/src/utils/my_colors.dart';
class ClientUpdatePage extends StatefulWidget {
  const ClientUpdatePage({Key key}) : super(key: key);

  @override
  _ClientUpdatePageState createState() => _ClientUpdatePageState();
}

class _ClientUpdatePageState extends State<ClientUpdatePage> {

  ClientUpdateController _con =  new ClientUpdateController();
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
        title: Text('Editar Perfil'),
      ),
        body: Container(
          width: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 50),
                _imageUserProfile(),
                SizedBox(height: 30),
                _textfieldname(),
                _textfieldlastname(),
                _textfieldphone(),
              ],
            ),
          ),
        ),
      bottomNavigationBar: _buttonRegister(),
    );
  }

  Widget _imageUserProfile() {
    return GestureDetector(
      onTap: _con.showAlertDialog,
      child: CircleAvatar(
        backgroundImage: _con.imageFile != null
            ? FileImage(_con.imageFile)
            : _con.user?.image != null
            ? NetworkImage(_con.user?.image)
            :AssetImage('assets/img/user_profile_2.png'),
        radius: 60,
        backgroundColor: Colors.grey[200],
      ),
    );
  }

  Widget _circle() {
    return Container(
      width: 240,
      height: 230,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: MyColors.primaryColor

      ),
    );
  }

  Widget _textfieldemail() {
    return  Container(
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 5),
      decoration: BoxDecoration(
          color: MyColors.primaryOpacityColor,
          borderRadius: BorderRadius.circular(30)
      ),
      child: TextField(
        controller: _con.emailController,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
            hintText: 'Correo Electronico',
            border: InputBorder.none,
            contentPadding: EdgeInsets.all(15),
            hintStyle: TextStyle(
                color: Colors.black54
            ),
            prefixIcon: Icon(
              Icons.email,
              color: Colors.amber,
            )
        ),
      ),
    );
  }

  Widget _textfieldname() {
    return  Container(
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 5),
      decoration: BoxDecoration(
          color: MyColors.primaryOpacityColor,
          borderRadius: BorderRadius.circular(30)
      ),
      child: TextField(
        controller: _con.nameController,
        decoration: InputDecoration(
            hintText: 'Nombre',
            border: InputBorder.none,
            contentPadding: EdgeInsets.all(15),
            hintStyle: TextStyle(
                color: Colors.black54
            ),
            prefixIcon: Icon(
              Icons.person,
              color: Colors.amber,
            )
        ),
      ),
    );
  }

  Widget _textfieldlastname() {
    return  Container(
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 5),
      decoration: BoxDecoration(
          color: MyColors.primaryOpacityColor,
          borderRadius: BorderRadius.circular(30)
      ),
      child: TextField(
        controller: _con.lastnameController,
        decoration: InputDecoration(
            hintText: 'Apellido',
            border: InputBorder.none,
            contentPadding: EdgeInsets.all(15),
            hintStyle: TextStyle(
                color: Colors.black54
            ),
            prefixIcon: Icon(
              Icons.person_outline,
              color: Colors.amber,
            )
        ),
      ),
    );
  }

  Widget _textfieldphone() {
    return  Container(
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 5),
      decoration: BoxDecoration(
          color: MyColors.primaryOpacityColor,
          borderRadius: BorderRadius.circular(30)
      ),
      child: TextField(
        controller: _con.phoneController,
        keyboardType: TextInputType.phone,
        decoration: InputDecoration(
            hintText: 'Telefono',
            border: InputBorder.none,
            contentPadding: EdgeInsets.all(15),
            hintStyle: TextStyle(
                color: Colors.black54
            ),
            prefixIcon: Icon(
              Icons.phone,
              color: Colors.amber,
            )
        ),
      ),
    );
  }

  Widget _buttonRegister() {
    return  Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 30),
      child: ElevatedButton(
        onPressed:_con.isEnable ? _con.update : null,
        child: Text(
          'ACTUALIZAR',
          style: TextStyle(
              fontSize: 15
          ),
        ),
        style: ElevatedButton.styleFrom(
            primary: Colors.black,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30)
            ),
            padding: EdgeInsets.symmetric(vertical: 15)
        ),
      ),
    );
  }
  Widget _iconBack() {
    return IconButton(
        onPressed: _con.back,
        icon: Icon(Icons.arrow_back_ios,color: Colors.white)
    );
  }

  Widget _textRegister() {
    return  Text(
        'ACTUALIZAR',
        style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 14,
            fontFamily: 'NimbusSans'
        )
    );
  }

  void refresh() {
    setState(() {});
  }

}
