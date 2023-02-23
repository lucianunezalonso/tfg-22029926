import 'package:flutter/material.dart';

class Opcion1Test extends StatefulWidget {
  @override
  _Opcion1TestState createState() => _Opcion1TestState();
}

class _Opcion1TestState extends State<Opcion1Test> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('AdoptionMovement'),
        centerTitle: true,
      ),
      body:
      Text('PANTALLA DEL MODELO DE RECOMENDACIONES'),

    );
  }
}