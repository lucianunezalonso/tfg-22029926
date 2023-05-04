import 'package:flutter/material.dart';

class Opcion1Test extends StatefulWidget {
  @override
  _Opcion1TestState createState() => _Opcion1TestState();
}

class _Opcion1TestState extends State<Opcion1Test> {
  // Inicialización de variables:
  final _formKey = GlobalKey<FormState>();
  String _especie = 'perro';
  String _raza= '';
  String _sexo = 'macho';
  String _tamano = 'grande';
  String _tiempo = 'reciente';
  String _edad = 'cachorro';
  bool? _microchip = false;

  int _years = 0;
  int _months = 0;

  final _yearsController = TextEditingController();
  final _monthsController = TextEditingController();

  @override
  void dispose() {
    _yearsController.dispose();
    _monthsController.dispose();
    super.dispose();
  }

// Raza	Especie	Sexo	Tamaño	Microchip	Tiempo	Edad
  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Modelo de recomendaciones'),
        centerTitle: true,
      ),

      body: Padding(
          padding: EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('Especie',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0),),
                DropdownButtonFormField(
                  value: _especie,
                  onChanged: (value) {
                    setState(() {
                        _especie = value.toString();
                    });
                  },
                  items: <String>['perro', 'gato']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                SizedBox(height: 16.0),
                Text('Tamaño',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0),),
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

                Text('Sexo',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0),),
                Row(
                  children: [
                    Flexible(
                      child: RadioListTile(
                        title: Text('Macho'),
                        value: 'macho',
                        groupValue: _sexo,
                        onChanged: (value) {
                          setState(() {
                            _sexo = value.toString();
                          });
                        },
                      ),
                    ),
                    Flexible(
                      child: RadioListTile(
                        title: Text('Hembra'),
                        value: 'hembra',
                        groupValue: _sexo,
                        onChanged: (value) {
                          setState(() {
                            _sexo = value.toString();
                          });
                        },
                      ),
                    ),
                  ],
                ),

                Text('Edad',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0),),
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


                const Text(
                  'Tiempo en estado de adopción',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                  ),
                ),
                const SizedBox(height: 16.0),
                Row(
                  children: [
                    Flexible(
                      child: TextFormField(
                        controller: _yearsController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          labelText: 'Años',
                          hintText: '0-12',
                        ),
                        validator: (value) {
                          final years = int.tryParse(value ?? '');
                          if (years == null || years < 0 || years > 12) {
                            return 'Ingresa un valor entre 0 y 12';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          setState(() {
                            _years = int.tryParse(value ?? '') ?? 0;
                          });
                        },
                      ),
                    ),
                    const SizedBox(width: 16.0),
                    Flexible(
                      child: TextFormField(
                        controller: _monthsController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          labelText: 'Meses',
                          hintText: '0-11',
                        ),
                        validator: (value) {
                          final months = int.tryParse(value ?? '');
                          if (months == null || months < 0 || months > 11) {
                            return 'Ingresa un valor entre 0 y 11';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          setState(() {
                            _months = int.tryParse(value ?? '') ?? 0;
                          });
                        },
                      ),
                    ),
                  ],
                ),

                CheckboxListTile(
                  title: const Text('Microchip',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0),),
                  value: _microchip,
                  onChanged: (value) {
                    setState(() {
                      _microchip = value;
                    });
                  },
                ),
                SizedBox(height: 1.0),
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
      );
  }
}







