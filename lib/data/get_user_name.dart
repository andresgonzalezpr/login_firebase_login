/*
* Andres Gonzalez
* SENA
* ficha :2470980
*
*
* */
//importamos el paquete de flutter para utilizar el framework
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class GetUsername extends StatelessWidget {
  final String documentId;
  GetUsername({required this.documentId});

  @override
  Widget build(BuildContext context) {
    //Realizamos el array con el primer y segundo nombre de la coleccion creada en Firebase
   CollectionReference users = FirebaseFirestore.instance.collection('Cuentas');

   return FutureBuilder<DocumentSnapshot>(
       future: users.doc(documentId).get(),
       builder: ((context,snapshot){

         if(snapshot.connectionState==ConnectionState.done){
           Map<String,dynamic> data= snapshot.data!.data() as Map<String,dynamic>;
           return Text('Nombre Usuario${data['first name']}${data['last name']}');
         }
         return const Text('cargando..');
       })
   );
  }
}
