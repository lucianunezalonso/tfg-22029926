import 'package:app_tfg/screens/opcion1_test.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';



class Opcion1Output extends StatelessWidget {
  final List<dynamic> resultData;

  Opcion1Output({required this.resultData});

  @override
  Widget build(BuildContext context) {
    final firstPageData = resultData.sublist(0, 5); // Obtener los primeros 5 elementos

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Centros recomendados'),
        centerTitle: true,
      ),
      body: Center(
        child: ListView.builder(
          itemCount: firstPageData.length,
          itemBuilder: (context, index) {
            final item = firstPageData[index];
            final itemIndex = index + 1; // Obtener el número de índice real

            return ListTile(
              title: Text('$itemIndex. ${item['Nombre'] ?? ''}'),
              subtitle: Text(item['CCAA']?.toString() ?? ''),
            );
          },
        ),
      ),

    );
  }
}
