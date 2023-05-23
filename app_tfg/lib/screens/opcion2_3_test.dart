import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_reorderable_list/flutter_reorderable_list.dart';
import 'package:google_fonts/google_fonts.dart';
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
        title: Text('Test de compatibilidad',style: GoogleFonts.montserrat(),),        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(19.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[

            SizedBox(height: 10.0),

            Text('9. Haga un ranking en función de los aspectos positivos que'
                ' más valore en un animal. Pulse las flechas para desplazar los ítems.'
              , style: GoogleFonts.montserrat(fontSize: 12.5),
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
}
