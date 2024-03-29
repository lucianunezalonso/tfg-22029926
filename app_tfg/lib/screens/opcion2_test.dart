import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../screens/opcion2_2_test.dart';

class Opcion2Test extends StatefulWidget {
  @override
  _Opcion2TestState createState() => _Opcion2TestState();
}

class _Opcion2TestState extends State<Opcion2Test> {

  String _selectedValue1 = ''; // Valor inicial pregunta 1
  String _selectedValue2 = ''; // Valor inicial pregunta 2
  String _selectedValue3 = ''; // Valor inicial pregunta 3
  String _selectedValue4 = ''; // Valor inicial pregunta 4
  String _selectedValue5 = ''; // Valor inicial pregunta 5



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

              // PRIMERA PREGUNTA

              SizedBox(height: 10.0),
              Text('1. ¿Incluirá a su mascota en actividades '
                  'que supongan salir de casa periódicamente? (playa, vacaciones,'
                  ' actividades de fin de semana…)',
                style: GoogleFonts.montserrat(fontSize: 12.5),
              ),

              Row(
                children: [
                  Flexible(
                    child: RadioListTile(
                      title: Text(
                        'SÍ',
                        style: GoogleFonts.montserrat(fontSize: 12),
                      ),
                      value: 'si',
                      groupValue: _selectedValue1,
                      onChanged: (value) {
                        setState(() {
                          _selectedValue1 = value as String;
                        });
                      },
                    ),
                  ),
                  Flexible(
                    child: RadioListTile(
                      title: Text(
                        'NO',
                        style: GoogleFonts.montserrat(fontSize: 12),
                      ),
                      value: 'no',
                      groupValue: _selectedValue1,
                      onChanged: (value) {
                        setState(() {
                          _selectedValue1 = value as String;
                        });
                      },
                    ),
                  ),
                ],
              ),


              // SEGUNDA PREGUNTA


              Text('2. ¿Su animal de compañía se relacionará generalmente'
                  ' con su entorno y círculo de amistades o pasará más tiempo '
                  'en su hogar?',
                style: GoogleFonts.montserrat(fontSize: 12.5),
              ),

              Row(
                children: [
                  Flexible(
                    child: RadioListTile(
                      title: Text('ENTORNO',
                        style: GoogleFonts.montserrat(fontSize: 12),
                      ),
                      value: 'entorno',
                      groupValue: _selectedValue2,
                      onChanged: (value) {
                        setState(() { _selectedValue2 = value as String;});
                      },
                    ),
                  ),
                  Flexible(
                    child: RadioListTile(
                      title: Text('HOGAR',
                        style: GoogleFonts.montserrat(fontSize: 12),
                      ),
                      value: 'hogar',
                      groupValue: _selectedValue2,
                      onChanged: (value) {
                        setState(() { _selectedValue2 = value as String;});
                      },
                    ),
                  ),
                ],
              ),

              // TERCERA PREGUNTA

              Text('3. ¿Cuánto tiempo pasará en casa o junto con el animal,'
                  ' la mayor parte del día o periodos cortos en horarios intermitentes?'
                , style: GoogleFonts.montserrat(fontSize: 12.5),
              ),

              Row(
                children: [
                  Flexible(
                    child: RadioListTile(
                      title: Text('LA MAYOR PARTE DEL DÍA',
                        style: GoogleFonts.montserrat(fontSize: 10),
                        ),
                      value: 'dia',
                      groupValue: _selectedValue3,
                      onChanged: (value) {
                        setState(() { _selectedValue3 = value as String;});
                      },
                    ),
                  ),
                  Flexible(
                    child: RadioListTile(
                      title: Text('PERIODOS CORTOS',
                        style: GoogleFonts.montserrat(fontSize: 10),
                      ),
                      value: 'periodos',
                      groupValue: _selectedValue3,
                      onChanged: (value) {
                        setState(() { _selectedValue3 = value as String;});
                      },
                    ),
                  ),
                ],
              ),

              // CUARTA PREGUNTA

              Text('4. ¿Convive con niños o tiene pensado hacerlo en un futuro?'
                ,style: GoogleFonts.montserrat(fontSize: 12.5),
              ),

              Row(
                children: [
                  Flexible(
                    child: RadioListTile(
                      title: Text('SÍ',
                        style: GoogleFonts.montserrat(fontSize: 12.0),
                        ),
                      value: 'si',
                      groupValue: _selectedValue4,
                      onChanged: (value) {
                        setState(() { _selectedValue4 = value as String;});
                      },
                    ),
                  ),
                  Flexible(
                    child: RadioListTile(
                      title: Text('NO',
                        style: GoogleFonts.montserrat(fontSize: 12),),
                      value: 'no',
                      groupValue: _selectedValue4,
                      onChanged: (value) {
                        setState(() { _selectedValue4 = value as String;});
                      },
                    ),
                  ),
                ],
              ),

              // QUINTA PREGUNTA

              Text('5. ¿Su residencia cuenta con alguna zona en la que su'
                  ' mascota se pueda mover libremente? (jardín, patio, finca…)'
                ,style: GoogleFonts.montserrat(fontSize: 12.5),
              ),

              Row(
                children: [
                  Flexible(
                    child: RadioListTile(
                      title: Text('SÍ',
                style: GoogleFonts.montserrat(fontSize: 12),),
                      value: 'si',
                      groupValue: _selectedValue5,
                      onChanged: (value) {
                        setState(() { _selectedValue5 = value as String;});
                      },
                    ),
                  ),
                  Flexible(
                    child: RadioListTile(
                      title: Text('NO',
                        style: GoogleFonts.montserrat(fontSize: 12),),
                      value: 'no',
                      groupValue: _selectedValue5,
                      onChanged: (value) {
                        setState(() { _selectedValue5 = value as String;});
                      },
                    ),
                  ),
                ],
              ),




              Center(
                child: ElevatedButton(
                  onPressed: () {
                    // ME COGE LAS VARIABLES DE ESTA PÁGINA
                    Map<String, dynamic> objetoJson = {
                      'actividades':_selectedValue1,
                      'relaciones': _selectedValue2,
                      'casa': _selectedValue3,
                      'niños': _selectedValue4,
                      'patio':_selectedValue5
                    };

                    // Convierte el map a json
                    String json1 = jsonEncode(objetoJson);

                    // Me las manda a la pagina siguiente
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => Opcion2_2Test(json1: json1),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFEE892F), // Establecer el color de fondo del botón
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