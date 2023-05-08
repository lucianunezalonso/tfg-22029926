import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class Opcion4Detalles extends StatelessWidget {
  final dynamic centro;

  Opcion4Detalles({required this.centro});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalles del centro'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Nombre: ${centro['Nombre']}'),

            Text('Dirección: ${centro['Direccion']}'),
            // Agrega aquí otros detalles que desees mostrar
          ],
        ),
      ),
    );
  }
}
