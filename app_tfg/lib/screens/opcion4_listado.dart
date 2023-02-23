import 'package:flutter/material.dart';

class Opcion4Listado extends StatefulWidget {
  @override
  _Opcion4ListadoState createState() => _Opcion4ListadoState();
}

class _Opcion4ListadoState extends State<Opcion4Listado> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('AdoptionMovement'),
        centerTitle: true,
      ),
      body:
        Text('PANTALLA DEL LISTADO DE CENTROS'),

    );
  }
}