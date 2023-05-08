import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'dart:convert';

class Opcion4Listado extends StatefulWidget {
  @override
  _Opcion4ListadoState createState() => _Opcion4ListadoState();
}

class _Opcion4ListadoState extends State<Opcion4Listado> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Visualización del DataFrame'),
      ),
      body: FutureBuilder<List<dynamic>>(
        future: fetchData(),
        builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            List<dynamic> data = snapshot.data as List<dynamic>; // Conversión explícita
            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (BuildContext context, int index) {
                var item = data[index];
                if (item is Map<String, dynamic>) {
                  return ListTile(
                    title: Text(item['Nombre'] ?? ''),
                    subtitle: Text(item['Direccion']?.toString() ?? ''),
                  );
                } else {
                  return ListTile(
                    title: Text(item?.toString() ?? ''),
                  );
                }
              },
            );
          }
        },
      ),
    );
  }

  Future<List<dynamic>> fetchData() async {
    try {
      final response = await Dio().get('http://10.100.25.199:8000/enviarcentros/');

      if (response.statusCode == 200) {
        // Decodificar la respuesta JSON
        List<dynamic> data = response.data;
        return data;
      } else {
        throw Exception('Error al obtener los datos del dataframe');
      }
    } catch (e) {
      throw Exception('Error de conexión: $e');
    }
  }

}

