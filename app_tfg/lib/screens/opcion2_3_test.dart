import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_reorderable_list/flutter_reorderable_list.dart';
import '../screens/opcion2_4_test.dart';



class Opcion2_3Test extends StatefulWidget {
  @override
  _Opcion2_3TestState createState() => _Opcion2_3TestState();

  final String json2;
  Opcion2_3Test({required this.json2});
}

class _Opcion2_3TestState extends State<Opcion2_3Test> {
  late String json2;
  late List<String> sortedItems;

  @override
  void initState() {
    super.initState();
    json2 = widget.json2;
    sortedItems = List.from(items);
  }

  List<String> items = [
    'Lealtad',
    'Alegría',
    'Inteligencia',
    'Fortaleza',
    'Belleza',
    'Capacidad de adaptación'
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
            const Text('PREGUNTA 9', style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 10.0),),
            const Text('Haga un ranking en función de los aspectos positivos que'
                ' más valore en un animal. Pulse las flechas para desplazar los ítems.'
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
                  Map<String, dynamic> objetoJson = {
                    'positivo1':sortedItems[0],
                    'positivo2': sortedItems[1],
                    'positivo3': sortedItems[2],
                    'positivo4': sortedItems[3],
                    'positivo5': sortedItems[4],
                    'positivo6': sortedItems[5]
                  };

                  var objetoJson2 = json.decode(json2);

                  // Combino los dos json
                  var combinedJson = {...objetoJson, ...objetoJson2};

                  // Convierte el map a json
                  String json3 = json.encode(combinedJson);

                  // Me las manda a la pagina siguiente
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => Opcion2_4Test(json3: json3),
                    ),
                  );

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
