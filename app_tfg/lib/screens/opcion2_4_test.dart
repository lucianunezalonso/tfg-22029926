import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_reorderable_list/flutter_reorderable_list.dart';


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
    'Recuperación de enfermedad',
    'Historial de enfermedades',
    'Víctima de maltrato',
    'Suelta pelo'

  ];

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
        title: Text('Test de compatibilidad'),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(19.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[

            SizedBox(height: 16.0),
            const Text('PREGUNTA 10', style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 10.0),),
            const Text('Haga un ranking en función de los aspectos negativos que'
                ' más rechazo le generen hacia un animal. Pulse las flechas para desplazar los ítems.'
              , style: TextStyle(
                  fontSize: 12.5),),

            SizedBox(height: 10.0),


            ListView.builder(
              shrinkWrap: true,
              itemCount: items.length,
              itemBuilder: (context, index) {
                final rankNumber = index + 1;
                return ListTile(
                  leading: CircleAvatar(
                    radius: 12.0, // Valor del radio más pequeño
                    child: Text(rankNumber.toString(),
                      style: TextStyle(fontSize: 12.0),
                    ),
                  ),
                  title: Text(items[index],
                    style: TextStyle(fontSize: 12.0),),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.arrow_upward),
                        iconSize: 20.0, // Tamaño del icono
                        onPressed: () => moveItemUp(index),
                      ),
                      IconButton(
                        icon: Icon(Icons.arrow_downward),
                        iconSize: 20.0, // Tamaño del icono
                        onPressed: () => moveItemDown(index),
                      ),

                    ],
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
                    '1negativo':sortedItems[0],
                    '2negativo': sortedItems[1],
                    '3negativo': sortedItems[2],
                    '4negativo': sortedItems[3],
                  };

                  var objetoJson3 = json.decode(json3);

                  // Combino los dos json
                  var combinedJson = {...objetoJson, ...objetoJson3};

                  // Convierte el map a json
                  String json4 = json.encode(combinedJson);

                },
                child: Text(
                  'Siguiente',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15.0,
                  ),
                ),
              ),
            ),


          ],
        ),

      ),


    );
  }
}
