/*
* Andres Gonzalez
* SENA
* ficha :2470980
*
*
* */
//importamos el paquete de flutter para utilizar el framework
import 'package:flutter/material.dart';
import 'package:login/pages/Login_page.dart';
import 'package:login/pages/register_page.dart';
//este widget nos permite lectura y escritura
class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  //creamos una variable booleana la cual nos mantiene en el inicio de sesion
  bool showLoginPage = true;

  void toggleScreens() {
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    //si estamos en el login nos registamos
    if (showLoginPage) {
      return Loginpage(showRegisterPage: toggleScreens);
    }
    //si no nos devuelve al login

    else {
      return RegisterPage(showLoginPage:toggleScreens);
    }
  }
}
