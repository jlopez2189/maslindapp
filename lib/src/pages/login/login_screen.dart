import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:maslindapp/src/pages/login/login_controller.dart';
import 'package:maslindapp/src/pages/login/signup_screen.dart';
import 'package:maslindapp/src/pages/register/register_page.dart';
///import 'package:login_ui_design/signup_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
  ///State<StatefulWidget> createState() => StartState();
}

class _LoginScreenState extends State<LoginScreen> {
  LoginController _con = new LoginController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      _con.init(context);
    });
  }

  Widget build(BuildContext context) {
    return initWidget();
  }

  initWidget() {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 300,
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
                          height: 246,
                          width: 230,
                        ),
                      ),
                    ],
                  )
              ),
            ),

            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.only(left: 20, right: 20, top: 70),
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
                    //color: Color(0xffF5591F),
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
              margin: EdgeInsets.only(left: 20, right: 20, top: 20),
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
                    Icons.vpn_key,
                    //color: Color(0xffF5591F),
                    color: Color(0xff020202),

                  ),
                  hintText: "Password",
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
              alignment: Alignment.centerRight,
              child: GestureDetector(
                onTap: () {
                  // Write Click Listener Code Here
                },
                child: Text(
                    "Olvistaste el Password?",
                  style: TextStyle(
                    color: Color(
                        0xff1A0378),
                  ),
                ),
              ),
            ),

            GestureDetector(
              onTap: () {
                _con.login();
              },
              child: Container(
                alignment: Alignment.center,
                margin: EdgeInsets.only(left: 20, right: 20, top: 20),
                padding: EdgeInsets.only(left: 20, right: 20),
                height: 50,
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
                child:   Text(
                         "INGRESAR",
                         style: TextStyle(
                         color: Colors.white,
                           fontWeight: FontWeight.bold
                    ),
                 ),
              ),
            ),

            Container(
              margin: EdgeInsets.only(top: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                      "No tienes cuenta?",
                    style: TextStyle(
                        fontWeight: FontWeight.bold
                    ),
                  ),
                 SizedBox(width: 6),
                  GestureDetector(
                   child: Text(
                      "Registrarse ahora",
                    style: TextStyle(
                           color: Color(
                               0xffF5591F
                           ),
                       fontWeight: FontWeight.bold
                      ),
                    ),
                    onTap: ()
                    {
                      _con.gotoRegisterPage();
                      // Write Tap Code Here.
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          //builder: (context) => SignUpScreen(),
                           builder: (context) => RegisterPage(),
                        )
                      );
                    },
                  )
                ],
              ),
            )
          ],
        )
      )
    );
  }
}