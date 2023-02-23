import 'package:flutter/material.dart';

class Opcion2Test extends StatefulWidget {
  @override
  _Opcion2TestState createState() => _Opcion2TestState();
}

class _Opcion2TestState extends State<Opcion2Test> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('AdoptionMovement'),
        centerTitle: true,
      ),
      body:
      Text('PANTALLA DEL MODELO DE MATCHES'),
    );
  }
}