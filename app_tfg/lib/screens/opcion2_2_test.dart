import 'package:flutter/material.dart';
import '../screens/opcion2_3_test.dart';
import 'dart:convert';

class Opcion2_2Test extends StatefulWidget {
  @override
  _Opcion2_2TestState createState() => _Opcion2_2TestState();

  final String json1;

  Opcion2_2Test({required this.json1});

}

class _Opcion2_2TestState extends State<Opcion2_2Test>  {

  late String json1;

  @override
  void initState() {
    super.initState();
    json1 = widget.json1;
  }

  String _selectedValue6 = ''; // Valor inicial pregunta 6
  String _selectedValue7 = ''; // Valor inicial pregunta 7
  String? _selectedValue8 = ''; // Valor inicial pregunta 8
  String? _selectedOption= '';


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

            // SEXTA PREGUNTA

            SizedBox(height: 16.0),
            const Text('PREGUNTA 6', style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 10.0),),
            const Text('¿Tiene o estaría dispuesto a tener licencia PPP?'
              , style: TextStyle(
                fontSize: 12.5),),

            Row(
              children: [
                Flexible(
                  child: RadioListTile(
                    title: const Text('SÍ',
                      style: TextStyle(fontSize: 10.0),),
                    value: 'si',
                    groupValue: _selectedValue6,
                    onChanged: (value) {
                      setState(() {
                        _selectedValue6 = value as String;
                      });
                    },
                  ),
                ),
                Flexible(
                  child: RadioListTile(
                    title: Text('NO',
                      style: TextStyle(fontSize: 10.0),),
                    value: 'no',
                    groupValue: _selectedValue6,
                    onChanged: (value) {
                      setState(() {
                        _selectedValue6 = value as String;
                      });
                    },
                  ),
                ),
              ],

            ),


            // SÉPTIMA PREGUNTA

            Text('PREGUNTA 7', style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 10.0),),
            Text('¿Preferiría un animal cariñoso y que busque '
                'afecto constantemente o uno que sea más independiente?', style: TextStyle(
                fontSize: 12.5),),

            Row(
              children: [
                Flexible(
                  child: RadioListTile(
                    title: Text('CARIÑOSO',
                      style: TextStyle(fontSize: 10.0),),
                    value: 'cariñoso',
                    groupValue: _selectedValue7,
                    onChanged: (value) {
                      setState(() {
                        _selectedValue7 = value as String;
                      });
                    },
                  ),
                ),
                Flexible(
                  child: RadioListTile(
                    title: Text('INDEPENDIENTE',
                      style: TextStyle(fontSize: 10.0),),
                    value: 'independiente',
                    groupValue: _selectedValue7,
                    onChanged: (value) {
                      setState(() {
                        _selectedValue7 = value as String;
                      });
                    },
                  ),
                ),
              ],
            ),

            // OCTAVA PREGUNTA

            Text('PREGUNTA 8', style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 10.0),),
            Text('¿Tiene actualmente o tendría pensado tener en un futuro otros animales?'
              , style: TextStyle(
                  fontSize: 12.5),),

            Row(
              children: [
                Flexible(
                  child: RadioListTile(
                    title: const Text('SÍ', style: TextStyle(fontSize: 10.0),),
                    value: 'si',
                    groupValue: _selectedValue8,
                    onChanged: (value) {
                      setState(() {
                        _selectedValue8 = value as String;
                        _selectedOption = null; //reinicia al cambiar el radiobutton
                      });                      },
                  ),
                ),
                Flexible(
                  child: RadioListTile(
                    title: Text('NO', style: TextStyle(fontSize: 10.0),),
                    value: 'no',
                    groupValue: _selectedValue8,
                    onChanged: (value) {
                      setState(() {
                        _selectedValue8 = value as String;
                        _selectedOption = null; // Reinicia el valor del DropdownButtonFormField
                      });
                      },
                  ),
                ),
              ],
            ),
            SizedBox(height: 7.0),

            Text('En caso afirmativo, ¿puede especificar más?'
              , style: TextStyle(
                  fontSize: 12.5),),
            DropdownButtonFormField(
              value: _selectedOption,
              onChanged: (value) {
                setState(() {
                  _selectedOption = value.toString();
                });
              },
              items: _selectedValue8 == 'si'
                  ? <String>['Gato', 'Gata', 'Perro','Perra'].map((String value) {
                return DropdownMenuItem<String>(
                  value: value.toLowerCase(),
                  child: Text(value,
                    style: TextStyle(fontSize: 13.0),),
                );
              }).toList()
                  : <String>[''].map((String value) {
                return DropdownMenuItem<String>(
                  value: value.toLowerCase(),
                  child: Text(value,
                    style: TextStyle(fontSize: 13.0),),
                );
              }).toList(),
            ),
            SizedBox(height: 13.0),



            Center(
              child: ElevatedButton(
                onPressed: () {

                  Map<String, dynamic> objetoJson = {
                    'ppp':_selectedValue6,
                    'cariño': _selectedValue7,
                    'animales': _selectedValue8,
                    'especie': _selectedOption,
                  };

                  var objetoJson1 = json.decode(json1);

                  // Combino los dos json
                  var combinedJson = {...objetoJson1, ...objetoJson};

                  // Convierte el map a json
                  String json2 = json.encode(combinedJson);

                  // Me las manda a la pagina siguiente
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => Opcion2_3Test(json2: json2),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFFE0BB76), // Establecer el color de fondo del botón
              ),
                child: Text(
                  'Siguiente',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15.0,
                      color: Colors.white
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