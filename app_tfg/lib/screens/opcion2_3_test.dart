import 'package:flutter/material.dart';
import 'package:flutter_reorderable_list/flutter_reorderable_list.dart';
import '../screens/opcion2_4_test.dart';



class Opcion2_3Test extends StatefulWidget {
  @override
  _Opcion2_3TestState createState() => _Opcion2_3TestState();
}

class _Opcion2_3TestState extends State<Opcion2_3Test> {

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
        final item = items.removeAt(index);
        items.insert(index - 1, item);
      }
    });
  }

  void moveItemDown(int index) {
    setState(() {
      if (index < items.length - 1) {
        final item = items.removeAt(index);
        items.insert(index + 1, item);
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
                      // SIGUIENTE PÁGINA
                      Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => Opcion2_4Test(),
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
