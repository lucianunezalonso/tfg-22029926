import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class Opcion4Detalles extends StatelessWidget {
  final dynamic centro;

  Opcion4Detalles({required this.centro});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('${centro['Nombre']}'),
        centerTitle: true,
      ),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('${centro['Nombre']}'),
            SizedBox(height: 20.0),

            Text('${centro['Direccion']}',textAlign: TextAlign.center,),
            SizedBox(height: 20.0),

            Table(
              border: TableBorder.all(color: Colors.grey),
              defaultColumnWidth: IntrinsicColumnWidth(),
              children: [
                TableRow(
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                  ),
                  children: [
                    TableCell(
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'Atributo 1',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    TableCell(
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('Valor 1'),
                      ),
                    ),
                  ],
                ),
                TableRow(
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                  ),
                  children: [
                    TableCell(
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'Atributo 2',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    TableCell(
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('Valor 2'),
                      ),
                    ),
                  ],
                ),
                // Agrega más filas según tus datos
              ],
            ),

          ],
        ),
      ),
    );
  }
}
