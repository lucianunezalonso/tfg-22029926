import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:app_tfg/screens/opcion2_output.dart';
import 'package:app_tfg/screens/GlobalVariable.dart';
import 'package:google_fonts/google_fonts.dart';


class Opcion2_4Test extends StatefulWidget {
  @override
  _Opcion2_4TestState createState() => _Opcion2_4TestState();
  final String json3;
  Opcion2_4Test({required this.json3});
}

class _Opcion2_4TestState extends State<Opcion2_4Test> {
  late String json3;
  late List<String> sortedItems;

  @override
  void initState() {
    super.initState();
    json3 = widget.json3;
    sortedItems = List.from(items);
  }

  List<String> items = [
    'Brutaldad',
    'Tristeza',
    'En recuperación (enfermedad)',
    'Historial de enfermedades',
    'Víctima de maltrato',
    'Suelta pelo'

  ];

  List<dynamic> resultData = []; // Variable de instancia para almacenar los datos

  void moveItemUp(int index) {
    setState(() {
      if (index > 0) {
        final item = sortedItems.removeAt(index);
        sortedItems.insert(index - 1, item);

        final originalItem = items.removeAt(index);
        items.insert(index - 1, originalItem);
      }
    });
  }

  void moveItemDown(int index) {
    setState(() {
      if (index < sortedItems.length - 1) {
        final item = sortedItems.removeAt(index);
        sortedItems.insert(index + 1, item);

        final originalItem = items.removeAt(index);
        items.insert(index + 1, originalItem);
      }
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Test de compatibilidad',style: GoogleFonts.montserrat(),),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(19.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[

            SizedBox(height: 10.0),

            Text('10. Haga un ranking en función de los aspectos negativos que'
                ' más rechazo le generen hacia un animal. Pulse las flechas para desplazar los ítems.',
              style: GoogleFonts.montserrat(fontSize: 12.5),
            ),

            SizedBox(height: 10.0),

            ListView.builder(
              shrinkWrap: true,
              itemCount: items.length,
              itemBuilder: (context, index) {
                final rankNumber = index + 1;
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: 6.0), // Establecer el espacio vertical entre cada elemento de la lista
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      color: Colors.grey[200],
                    ),
                    child: ListTile(
                      leading: CircleAvatar(
                        radius: 12.0,
                        backgroundColor: Colors.grey[600], // Color de fondo más oscuro
                        child: Text(
                          rankNumber.toString(),
                          style: GoogleFonts.montserrat(
                              fontSize: 14.0,color: Colors.white),
                        ),
                      ),
                      title: Text(
                        items[index],
                        style: GoogleFonts.montserrat(
                            fontSize: 13.0),
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(Icons.arrow_upward),
                            iconSize: 20.0,
                            onPressed: () => moveItemUp(index),
                          ),
                          IconButton(
                            icon: Icon(Icons.arrow_downward),
                            iconSize: 20.0,
                            onPressed: () => moveItemDown(index),
                          ),
                        ],
                      ),
                    ),
                  ),
                );


              },
            ),


            SizedBox(height: 20.0),

            Center(
              child: ElevatedButton(
                onPressed: () {
                  // PÁGINA DE LOS RESULTADOS DEL MODELO
                  Map<String, dynamic> objetoJson = {
                    'negativo1':sortedItems[0],
                    'negativo2': sortedItems[1],
                    'negativo3': sortedItems[2],
                    'negativo4': sortedItems[3],
                    'negativo5':sortedItems[4],
                    'negativo6':sortedItems[5]
                  };

                  var objetoJson3 = json.decode(json3);

                  // Combino los dos json
                  var combinedJson = {...objetoJson, ...objetoJson3};

                  print(combinedJson);
                  // Convierte el map a json
                  // String json4 = json.encode(combinedJson);

                  mandarVariables2(combinedJson.cast<String, dynamic>());

                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFE0BB76), // Establecer el color de fondo del botón
                ),
                child: Text(
                  'Siguiente',
                  style: GoogleFonts.montserrat(fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future mandarVariables2(Map<String, dynamic> datos) async {
    try {


      print(datos);
      final response = await Dio().get(
          "http://${GlobalVariable().ip}:8000/recogerdatos2/",
          queryParameters: datos
      );

      if (response.statusCode == 200) {
        // Decodificar la respuesta JSON
        List<dynamic> data = response.data;

        resultData = data;

        print(data);

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Opcion2Output(resultData: resultData),
          ),
        );
      } else {
        throw Exception('Error al obtener los datos del dataframe');
      }
    } catch (e) {
      throw Exception('Error de conexión: $e');
    }
  }

}
