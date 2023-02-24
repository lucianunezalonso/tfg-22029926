import 'package:flutter/material.dart';

class Opcion1Test extends StatefulWidget {
  @override
  _Opcion1TestState createState() => _Opcion1TestState();
}

class _Opcion1TestState extends State<Opcion1Test> {
  // Inicialización de variables:
  final _formKey = GlobalKey<FormState>();
  String _especie = 'perro';
  String _sexo = 'macho';
  String _tamano = 'grande';
  String _nivelActividad = 'alto';
  String _ingreso = 'reciente';
  String _edad = 'cachorro';
  bool? _vacunado = false;
  bool? _desparasitado = false;
  bool? _sano = false;
  bool? _esterilizado = false;
  bool? _microchip = false;


  @override
  Widget build(BuildContext context) {
    final _scrollController = ScrollController();

    return Scaffold(
        appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Modelo de recomendaciones'),
        centerTitle: true,
      ),

      body: Scrollbar(
        controller: _scrollController,
        isAlwaysShown: true,
        thickness: 8.0,
        radius: Radius.circular(10.0),

        child: SingleChildScrollView(
            controller: _scrollController,

            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('Especie'),
                    DropdownButtonFormField(
                      value: _especie,
                      onChanged: (value) {
                        setState(() {
                            _especie = value.toString();
                        });
                      },
                      items: <String>['perro', 'cobaya', 'conejo', 'gato', 'hurón']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                    SizedBox(height: 16.0),
                    Text('Sexo'),
                    RadioListTile(
                      title: Text('Macho'),
                      value: 'macho',
                      groupValue: _sexo,
                      onChanged: (value) {
                        setState(() {
                          _sexo = value.toString();
                        });
                      },
                    ),
                    RadioListTile(
                      title: Text('Hembra'),
                      value: 'hembra',
                      groupValue: _sexo,
                      onChanged: (value) {
                        setState(() {
                          _sexo = value.toString();
                        });
                      },
                    ),
                    SizedBox(height: 16.0),
                    Text('Tamaño'),
                    DropdownButtonFormField(
                      value: _tamano,
                      onChanged: (value) {
                      setState(() {
                        _tamano = value.toString();
                      });
                    },
                    items: <String>['grande', 'mediano', 'pequeño']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                  SizedBox(height: 16.0),
                  Text('Nivel de actividad'),
                  DropdownButtonFormField(
                    value: _nivelActividad,
                    onChanged: (value) {
                      setState(() {
                        _nivelActividad = value.toString();
                      });
                    },
                    items: <String>['alto', 'medio', 'bajo']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                  SizedBox(height: 16.0),
                  Text('Ingreso'),
                  DropdownButtonFormField(
                    value: _ingreso,
                    onChanged: (value) {
                      setState(() {
                        _ingreso = value.toString();
                      });
                    },
                    items: <String>['reciente', 'medio', 'antiguo']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                    SizedBox(height: 16.0),
                    Text('Edad'),
                    DropdownButtonFormField(
                      value: _edad,
                      onChanged: (value) {
                        setState(() {
                          _edad = value.toString();
                        });
                      },
                      items: <String>['cachorro', 'joven', 'adulto', 'senior']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                    SizedBox(height: 16.0),
                    CheckboxListTile(
                      title: Text('Vacunado'),
                      value: _vacunado,
                      onChanged: (value) {
                        setState(() {
                          _vacunado = value;
                        });
                      },
                    ),
                    CheckboxListTile(
                      title: Text('Desparasitado'),
                      value: _desparasitado,
                      onChanged: (value) {
                        setState(() {
                          _desparasitado = value;
                        });
                      },
                    ),
                    CheckboxListTile(
                      title: Text('Sano'),
                      value: _sano,
                      onChanged: (value) {
                        setState(() {
                          _sano = value;
                        });
                      },
                    ),
                    CheckboxListTile(
                      title: Text('Esterilizado'),
                      value: _esterilizado,
                      onChanged: (value) {
                        setState(() {
                          _esterilizado = value;
                        });
                      },
                    ),
                    CheckboxListTile(
                      title: Text('Microchip'),
                      value: _microchip,
                      onChanged: (value) {
                        setState(() {
                          _microchip = value;
                        });
                      },
                    ),
                    SizedBox(height: 16.0),
                    Center(
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState?.validate() == true) {
                          // Aquí tendrían que mandarse los datos al modelo
                          }
                        },
                        child: Text('Enviar'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
  }
}







