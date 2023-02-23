import 'package:flutter/material.dart';

class Opcion3Listado extends StatefulWidget {
  @override
  _Opcion3ListadoState createState() => _Opcion3ListadoState();
}

class _Opcion3ListadoState extends State<Opcion3Listado> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('AdoptionMovement'),
        centerTitle: true,
      ),
      body:
      Text('PANTALLA DEL LISTADO DE COMPATIBLES'),
    );
  }
}