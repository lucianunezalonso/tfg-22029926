import 'package:app_tfg/screens/opcion1_test.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';



class Opcion1Output extends StatelessWidget {
  List<dynamic> resultData;

  Opcion1Output({required this.resultData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Centros recomendados'),
        centerTitle: true,
      ),
      body: Center(
        child: ListView.builder(
          itemCount: resultData.length,
          itemBuilder: (context, index) {
            final item = resultData[index];
            return ListTile(
              title: Text(item['Nombre'] ?? ''),
              subtitle: Text(item['Direccion']?.toString() ?? ''),
            );
          },
        ),
      ),
    );
  }
}
