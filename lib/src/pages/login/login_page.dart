import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:lottie/lottie.dart';
import 'package:maslindapp/src/pages//login/login_controller.dart';
import 'package:maslindapp/src/utils/my_colors.dart';
class LoginPage extends StatefulWidget {
  const LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  LoginController _con = new LoginController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
     SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      _con.init(context);
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       body: Container(
         width: double.infinity,
         child: Stack(
           children: [
             Positioned(
                 top: -80,
                 left: -100,
                 child: _circleLogin()
             ),
             Positioned(
                 child: _textLogin(),
                 top: 60,
                 left: 25,
             ),
             SingleChildScrollView(
               child: Column(
                  children: [
                    _imageBanner(),
                    _textfieldemail(),
                    _textfieldpassword(),
                    _buttonlogin(),
                    _textDontHaveAccount()
                 ],
               ),
             ),
           ],
         ),
       )
    );
  }

  Widget _lottieAnimation() {
    return Lottie.asset(
        'assets/json/',
         width: 350,
         height: 200,
         fit: BoxFit.fill
    );
  }

  Widget _textLogin() {
    return Text(
      'LOGIN',
      style: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: 22
      ),
    );
  }

  Widget _textDontHaveAccount() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'No tienes cuenta?',
          style: TextStyle(
              color: Colors.black,
              fontSize: 17
          ),
        ),
        SizedBox(width: 7),
        GestureDetector(
          onTap: _con.gotoRegisterPage,
          child: Text(
            'Registrate',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple,
                fontSize: 17
            ),
          ),
        ),
      ],
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

  Widget _textfieldpassword() {
    return  Container(
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 5),
      decoration: BoxDecoration(
          color: MyColors.primaryOpacityColor,
          borderRadius: BorderRadius.circular(30)
      ),
      child: TextField(
        controller: _con.passController,
        obscureText: true,
        decoration: InputDecoration(
            hintText: 'Password',
            border: InputBorder.none,
            contentPadding: EdgeInsets.all(15),
            hintStyle: TextStyle(
                color: Colors.black54
            ),
            prefixIcon: Icon(
              Icons.lock,
              color: Colors.amber,
            )
        ),
      ),
    );
  }
  Widget _buttonlogin() {
    return  Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 30),
      child: ElevatedButton(
          onPressed: _con.login,
          child: Text(
              'Ingresar',
               style: TextStyle(
                 fontSize: 17
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
  Widget _circleLogin() {
    return Container(
      width: 240,
      height: 230,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: MyColors.primaryColor
      ),
    );
  }
  Widget _imageBanner() {
   return Container(
     margin: EdgeInsets.only(
         top: 140,
         bottom: MediaQuery.of(context).size.height * 0.05
     ),
     child: Image.asset(
        'assets/img/Logomaslinda1.png',
        width: 260,
        height: 260,
      ),
   );
  }
}
