/*
* Andres Gonzalez
* SENA
* ficha :2470980
*
*
* */
//importamos el paquete de flutter para utilizar el framework
import 'package:flutter/material.dart';
//Importamos el firebase para autenticar
import 'package:firebase_auth/firebase_auth.dart';

//Este Widget nos permite leer y escribir
class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  //definimos esta varaiabale para controlar el email
  final _emailController = TextEditingController();
//El metodo future lo llamamos pero no lo utilizamos para restaurar la contraseña
  Future passwordReset() async {
    //el punto trim nos sirve texto contiene espacios en blanco iniciales o finales, se devuelve una nueva cadena sin iniciales ni espacios en blanco
    var cuentaEmail = _emailController.text.trim();
    //hacemos este try - catch para capturar si pasaa algun error
    try {
      //esperamos la respuesta del firebase para ver la si la cuenta existe
      await FirebaseAuth.instance.sendPasswordResetEmail(email: cuentaEmail);
      showDialog<void>(
        context: context,
        //nos sirve para descartar una ruta
        barrierDismissible: true,
        builder: (BuildContext dialogContext) {
          //nos mostrara un mensaje o una pantalla
          return AlertDialog(
            title: const Text('Recuperacion de contraseña'),
            content: Text('Un email fue enviado a la cuenta $cuentaEmail'),
            actions: <Widget>[
              TextButton(
                child: const Text('Cerrar'),
                onPressed: () {
                  Navigator.of(dialogContext).pop();
                },
              ),
            ],
          );
        },
      );
    }
    //es una excepcion de fire base en caso de no encontrar el correo
    on FirebaseAuthException catch (e) {
      print(e);
      showDialog<void>(
        context: context,
        //nos sirve para descartar una ruta
        barrierDismissible: true,
        builder: (BuildContext dialogContext) {
          //nos mostrara una alerta en caso de no encontrar
          return AlertDialog(
            title: const Text('Firebase Error'),
            content: Text('Email error:$e'),
            actions: <Widget>[
              TextButton(
                child: const Text('Cerrar'),
                onPressed: () {
                  Navigator.of(dialogContext).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }
//nos sirve para liberar la memoria asignada a las variables cuando se quita el objeto de estado.
  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    //Le damos diseño a la hoja con este widget
    return Scaffold(
      //creamos un header de color morado
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        elevation: 0,
      ),
      //creamos una columna centrada
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          //este padding nos ayudar a colocar un texto centrado y de cierto tamaño
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 25.0),
            child: Text(
              'Ingrese su email para enviarle'
              'un email de restablecimiento de contraseña',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20),
            ),
          ),
          //se define como un cuadro con un tamaño especificado
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            //creamos una caja de texto para validar el correo
            child: TextField(
              controller: _emailController,
              //cuando le damos click se hace un borde morado y de fondo colocamos la palaba email
              decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(12)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.deepPurple),
                      borderRadius: BorderRadius.circular(12)),
                  hintText: 'Email',
                  fillColor: Colors.grey[200],
                  filled: true),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          //creamos un boton el  cual nos realiza el metodo future cuando le de click
          MaterialButton(
            onPressed:passwordReset,
            color: Colors.deepPurple[200],
            child: const Text(
              'Restablecer Contraseña',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16),
            ),
          )
        ],
      ),
    );
  }
}
