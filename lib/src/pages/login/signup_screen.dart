import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:maslindapp/src/pages/register/register_controller.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {

  RegisterController _con =  new RegisterController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      _con.init(context, refresh);
    });
  }

  @override
  Widget build(BuildContext context) => initWidget();

  Widget _iconBack() {
    return IconButton(
        onPressed: _con.back,
        icon: Icon(Icons.arrow_back_ios,color: Colors.white)
    );
  }

  Widget _imageUserProfile() {
    return GestureDetector(
      onTap: _con.showAlertDialog,
      child: CircleAvatar(
        backgroundImage: _con.imageFile != null
            ? FileImage(_con.imageFile)
            : AssetImage('assets/img/user_profile_2.png'),
        radius: 60,
        backgroundColor: Colors.grey[200],
      ),
    );
  }

  Widget initWidget() {
    return Scaffold(
        body: SingleChildScrollView(
            child: Column(
               children: [
                  Container(
                  height: 250,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(90)),
                    color: new Color(0xff020202),
                    gradient: LinearGradient(colors: [(new  Color(0xff020202)), new Color(0xff020202)],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                  child: Center(
                       child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [

                          Container(
                            margin: EdgeInsets.only(top: 50),
                            child: Image.asset(
                              "assets/img/Logomaslinda.png",
                              height: 200,
                              width: 220,
                            ),
                          ),
                    ],
                      )
                  ),
                ),

                _imageUserProfile(),

                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(left: 20, right: 20, top: 40),
                  padding: EdgeInsets.only(left: 20, right: 20),
                  height: 54,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Colors.grey[200],
                    boxShadow: [
                      BoxShadow(
                          offset: Offset(0, 10),
                          blurRadius: 50,
                          color: Color(0xffEEEEEE)
                      ),
                    ],
                  ),
                  child: TextField(
                    controller: _con.nameController,
                    cursorColor: Color(0xffF5591F),
                    decoration: InputDecoration(
                      icon: Icon(
                        Icons.person,
                        color: Color(0xff020202),
                      ),
                      hintText: "Nombre",
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                    ),
                  ),
                ),

                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(left: 20, right: 20, top: 10),
                  padding: EdgeInsets.only(left: 20, right: 20),
                  height: 54,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Colors.grey[200],
                    boxShadow: [
                      BoxShadow(
                          offset: Offset(0, 10),
                          blurRadius: 50,
                          color: Color(0xffEEEEEE)
                      ),
                    ],
                  ),
                  child: TextField(
                    controller: _con.lastnameController,
                    cursorColor: Color(0xffF5591F),
                    decoration: InputDecoration(
                      icon: Icon(
                        Icons.person_outline,
                        color: Color(0xff020202),
                      ),
                      hintText: "Apellido",
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                    ),
                  ),
                ),

                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(left: 20, right: 20, top: 10),
                  padding: EdgeInsets.only(left: 20, right: 20),
                  height: 54,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Colors.grey[200],
                    boxShadow: [
                      BoxShadow(
                          offset: Offset(0, 10),
                          blurRadius: 50,
                          color: Color(0xffEEEEEE)
                      ),
                    ],
                  ),
                  child: TextField(
                    controller: _con.emailController,
                    keyboardType: TextInputType.emailAddress,
                    cursorColor: Color(0xffF5591F),
                    decoration: InputDecoration(
                      icon: Icon(
                        Icons.email,
                        color: Color(0xff020202),
                      ),
                      hintText: "Correo Electronico",
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                    ),
                  ),
                ),

                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(left: 20, right: 20, top: 10),
                  padding: EdgeInsets.only(left: 20, right: 20),
                  height: 54,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Color(0xffEEEEEE),
                    boxShadow: [
                      BoxShadow(
                          offset: Offset(0, 20),
                          blurRadius: 100,
                          color: Color(0xffEEEEEE)
                      ),
                    ],
                  ),
                  child: TextField(
                    controller: _con.phoneController,
                    keyboardType: TextInputType.phone,
                    cursorColor: Color(0xffF5591F),
                    decoration: InputDecoration(
                      focusColor: Color(0xffF5591F),
                      icon: Icon(
                        Icons.phone,
                        color: Color(0xff020202),
                      ),
                      hintText: "Telefono",
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(left: 20, right: 20, top: 10),
                  padding: EdgeInsets.only(left: 20, right: 20),
                  height: 54,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Color(0xffEEEEEE),
                    boxShadow: [
                      BoxShadow(
                          offset: Offset(0, 20),
                          blurRadius: 100,
                          color: Color(0xffEEEEEE)
                      ),
                    ],
                  ),
                  child: TextField(
                    controller: _con.passController,
                    obscureText: true,
                    cursorColor: Color(0xffF5591F),
                    decoration: InputDecoration(
                      focusColor: Color(0xffF5591F),
                      icon: Icon(
                        Icons.lock,
                        color: Color(0xff020202),
                      ),
                      hintText: "Password",
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                    ),
                  ),
                ),

                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(left: 20, right: 20, top: 10),
                  padding: EdgeInsets.only(left: 20, right: 20),
                  height: 54,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Color(0xffEEEEEE),
                    boxShadow: [
                      BoxShadow(
                          offset: Offset(0, 20),
                          blurRadius: 100,
                          color: Color(0xffEEEEEE)
                      ),
                    ],
                  ),
                  child: TextField(
                    controller: _con.confirmpassController,
                    obscureText: true,
                    cursorColor: Color(0xffF5591F),
                    decoration: InputDecoration(
                      focusColor: Color(0xffF5591F),
                      icon: Icon(
                        Icons.lock_outline,
                        color: Color(0xff020202),
                      ),
                      hintText: "Confirmar Password",
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                    ),
                  ),
                ),


                GestureDetector(

                  onTap: () {
                     _con.register();
                    },
                  child: Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(left: 20, right: 20, top: 30),
                    padding: EdgeInsets.only(left: 20, right: 20),
                    height: 54,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [(new  Color(0xff0D1B04)), new Color(0xff205E11) ,new Color(0xff205E11) ,new Color(0xff0D1B04)],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight
                      ),
                      borderRadius: BorderRadius.circular(50),
                      color: Colors.grey[200],
                      boxShadow: [
                        BoxShadow(
                            offset: Offset(0, 10),
                            blurRadius: 50,
                            color: Color(0xffEEEEEE)
                        ),
                      ],
                    ),
                    child: Text(
                      "REGISTRAR",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                ),

              ],
            )
        )
    );
  }
  void refresh() {
    setState(() {});
  }

}