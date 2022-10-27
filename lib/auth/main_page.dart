/*
* Andres Gonzalez
* SENA
* ficha :2470980
*
*
* */
//importamos el paquete de flutter para utilizar el framework
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:login/auth/auth_page.dart';
import 'package:login/pages/home_page.dart';
class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    //nos ayuda a darle un diseño a la hoja
    return Scaffold(
      //Generamos el usuario
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context,snapshot){
          //si el usuario existe nos envia homepage
          if(snapshot.hasData){
            return const HomePage();
          }
          //si no,nos manda a autenticar
          else{
            return const AuthPage();
          }
        }
      ),
    );
  }
}
