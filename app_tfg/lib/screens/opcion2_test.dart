import 'package:flutter/material.dart';

class Opcion2Test extends StatefulWidget {
  @override
  _Opcion2TestState createState() => _Opcion2TestState();
}

class _Opcion2TestState extends State<Opcion2Test> {

  int _selectedValue = 3; // Valor inicial

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

              // PRIMERA PREGUNTA

              SizedBox(height: 16.0),
              Text('PREGUNTA 1',style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 10.0),),
              Text('¿Incluirá a su mascota en actividades '
                  'que supongan salir de casa periódicamente? (playa, vacaciones,'
                  ' actividades de fin de semana…)'),

              Row(
                children: [
                  Flexible(
                    child: RadioListTile(
                      title: Text('SÍ',
                        style: TextStyle(fontSize: 10.0),),
                      value: 'si',
                      groupValue: _selectedValue,
                      onChanged: (value) {
                        setState(() { _selectedValue = value as int;});
                      },
                    ),
                  ),
                  Flexible(
                    child: RadioListTile(
                      title: Text('NO',
                        style: TextStyle(fontSize: 10.0),),
                      value: 'no',
                      groupValue: _selectedValue,
                      onChanged: (value) {
                        setState(() { _selectedValue = value as int;});
                      },
                    ),
                  ),
                ],

              ),


              // SEGUNDA PREGUNTA

              Text('PREGUNTA 2',style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 10.0),),
              Text('¿Su animal de compañía se relacionará generalmente'
                  ' con su entorno y círculo de amistades o pasará más tiempo '
                  'en su hogar?'),

              Row(
                children: [
                  Flexible(
                    child: RadioListTile(
                      title: Text('ENTORNO',
                        style: TextStyle(fontSize: 10.0),),
                      value: 'entorno',
                      groupValue: _selectedValue,
                      onChanged: (value) {
                        setState(() { _selectedValue = value as int;});
                      },
                    ),
                  ),
                  Flexible(
                    child: RadioListTile(
                      title: Text('HOGAR',
                        style: TextStyle(fontSize: 10.0),),
                      value: 'hogar',
                      groupValue: _selectedValue,
                      onChanged: (value) {
                        setState(() { _selectedValue = value as int;});
                      },
                    ),
                  ),
                ],
              ),

              // TERCERA PREGUNTA

              Text('PREGUNTA 3',style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 10.0),),
              Text('¿Cuánto tiempo pasará en casa o junto con el animal,'
                  ' la mayor parte del día o periodos cortos en horarios intermitentes?'),

              Row(
                children: [
                  Flexible(
                    child: RadioListTile(
                      title: Text('LA MAYOR PARTE DEL DÍA',
                        style: TextStyle(fontSize: 10.0),),
                      value: 'dia',
                      groupValue: _selectedValue,
                      onChanged: (value) {
                        setState(() { _selectedValue = value as int;});
                      },
                    ),
                  ),
                  Flexible(
                    child: RadioListTile(
                      title: Text('PERIODOS CORTOS',
                        style: TextStyle(fontSize: 10.0),),
                      value: 'periodos',
                      groupValue: _selectedValue,
                      onChanged: (value) {
                        setState(() { _selectedValue = value as int;});
                      },
                    ),
                  ),
                ],
              ),

              // CUARTA PREGUNTA

              Text('PREGUNTA 4',style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 10.0),),
              Text('¿Convive con niños o tiene pensado hacerlo en un futuro?'),

              Row(
                children: [
                  Flexible(
                    child: RadioListTile(
                      title: Text('SÍ',
                        style: TextStyle(fontSize: 10.0),),
                      value: 'si',
                      groupValue: _selectedValue,
                      onChanged: (value) {
                        setState(() { _selectedValue = value as int;});
                      },
                    ),
                  ),
                  Flexible(
                    child: RadioListTile(
                      title: Text('NO',
                        style: TextStyle(fontSize: 10.0),),
                      value: 'no',
                      groupValue: _selectedValue,
                      onChanged: (value) {
                        setState(() { _selectedValue = value as int;});
                      },
                    ),
                  ),
                ],
              ),

              // QUINTA PREGUNTA

              Text('PREGUNTA 5',style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 10.0),),
              Text('¿Su residencia cuenta con alguna zona en la que su'
                  ' mascota se pueda mover libremente? (jardín, patio, finca…)'),

              Row(
                children: [
                  Flexible(
                    child: RadioListTile(
                      title: Text('SÍ',
                        style: TextStyle(fontSize: 10.0),),
                      value: 'si',
                      groupValue: _selectedValue,
                      onChanged: (value) {
                        setState(() { _selectedValue = value as int;});
                      },
                    ),
                  ),
                  Flexible(
                    child: RadioListTile(
                      title: Text('NO',
                        style: TextStyle(fontSize: 10.0),),
                      value: 'no',
                      groupValue: _selectedValue,
                      onChanged: (value) {
                        setState(() { _selectedValue = value as int;});
                      },
                    ),
                  ),
                ],
              ),






              Center(
                child: ElevatedButton(
                    onPressed: () {
                      // QUE APAREZCA OTRA PANTALLA CON EL RESULTADO DEL MODELO
                    },
                    child: Text('Enviar',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15.0),),
                ),
              ),





            ],
          ),

      ),



    );
  }
}