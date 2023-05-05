import 'package:flutter/material.dart';

class Opcion1Test extends StatefulWidget {
  @override
  _Opcion1TestState createState() => _Opcion1TestState();
}

class _Opcion1TestState extends State<Opcion1Test> {
  // Inicialización de variables:
  final _formKey = GlobalKey<FormState>();
  String _especie = 'Canina';
  String? _raza= 'mestizo';
  String _sexo = 'macho';
  String? _tamano = 'grande';

  bool? _microchip = false;

  final List<String> _razasCaninas = ['Mestizo', 'Pastor Belga', 'Mastín', 'Yorkshire Terrier',
    'Setter', 'Border Collie', 'Malinois', 'Podenco', 'Spaniel','Setter Irlandés', 'Pastor Alemán',
    'Pointer', 'Golden Retriever','Ratonero Bodeguero Andaluz', 'Pastor Vasco', 'Teckel',
    'Setter Inglés', 'Galgo', 'Husky Siberiano'];

  final List<String> _razasFelinas = ['Común Europeo'];


  int _years = 0;
  int _months = 0;

  final _yearsControllerEdad = TextEditingController();
  final _monthsControllerEdad = TextEditingController();

  final _yearsControllerTiempo = TextEditingController();
  final _monthsControllerTiempo = TextEditingController();

  @override
  void disposeEdad() {
    _yearsControllerEdad.dispose();
    _monthsControllerEdad.dispose();
    super.dispose();
  }

  void disposeTiempo() {
    _yearsControllerTiempo.dispose();
    _monthsControllerTiempo.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Características del animal:'),
        centerTitle: true,
      ),

      body: Padding(

          padding: EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                //-------------------------------------------------------------- ESPECIE
                SizedBox(height: 12.0),
                const Text('Especie',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0),),

                  SizedBox(
                    height: 38,
                      child: DropdownButtonFormField(
                      value: _especie,
                      onChanged: (value) {
                        setState(() {
                          _especie = value.toString();
                          _tamano = null; //reinicia el valor al seleccionar otra especie
                          _raza= null; // reinicia el valor al seleccionar otra especie
                        });
                      },
                      items: <String>['Canina', 'Felina'].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value,
                          style: TextStyle(fontSize: 13.0),),
                        );
                      }).toList(),
                    ),
                  ),

                      SizedBox(height: 13.0),

                //---------------------------------------------------------------- RAZA
                const Text('Raza',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0),),
                SizedBox(
                  height: 38,
                  child: DropdownButtonFormField(
                      value: _raza,
                      onChanged: (value) {
                        setState(() {
                          _raza = value.toString();
                        });
                      },
                      items: _especie == 'Canina'
                          ? _razasCaninas.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value.toLowerCase(),
                          child: Text(value,
                            style: TextStyle(fontSize: 13.0),),
                        );
                      }).toList()
                          : _razasFelinas.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value.toLowerCase(),
                          child: Text(value,
                            style: TextStyle(fontSize: 13.0),),
                        );
                      }).toList(),
                    ),
                ),


                SizedBox(height: 12.0),
              //---------------------------------------------------------------- TAMAÑO
                const Text('Tamaño',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0),),

                  SizedBox(
                    height: 38,
                    child: DropdownButtonFormField(
                        value: _tamano,
                        onChanged: (value) {
                          setState(() {
                            _tamano = value.toString();
                          });
                        },
                        items: _especie == 'Canina'
                            ? <String>['Pequeño', 'Mediano', 'Grande'].map((String value) {
                          return DropdownMenuItem<String>(
                            value: value.toLowerCase(),
                            child: Text(value,
                              style: TextStyle(fontSize: 13.0),),
                          );
                        }).toList()
                            : <String>['Pequeño'].map((String value) {
                          return DropdownMenuItem<String>(
                            value: value.toLowerCase(),
                            child: Text(value,
                              style: TextStyle(fontSize: 13.0),),
                          );
                        }).toList(),
                      ),
                  ),
                SizedBox(height: 10.0),


              //---------------------------------------------------------------- SEXO
                const Text('Sexo',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15.0),),
                Row(
                  children: [
                    Flexible(
                      child: RadioListTile(
                        title: Text('Macho',
                          style: TextStyle(fontSize: 13.0),),
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
                        title: Text('Hembra',
                          style: TextStyle(fontSize: 13.0),),
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


              //---------------------------------------------------------------- EDAD
                Text('Edad',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15.0),),
                SizedBox(
                height: 38,
                child:
                    Row(
                      children: [
                        Flexible(
                          child: TextFormField(
                            controller: _yearsControllerEdad,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              labelText: 'Años',
                              hintText: '0-12',
                            ),
                            validator: (value) {
                              final years = int.tryParse(value ?? '');
                              if (years == null || years < 0 || years > 25) {
                                return 'Ingresa un valor entre 0 y 25';
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
                        //const SizedBox(width: 16.0),
                        Flexible(
                          child: TextFormField(
                            controller: _monthsControllerEdad,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              labelText: 'Meses',
                              hintText: '0-11',
                            ),
                            validator: (value) {
                              final months = int.tryParse(value ?? '');
                              if (months == null || months < 0 || months > 12) {
                                return 'Ingresa un valor entre 0 y 12';
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
                ),
                SizedBox(height: 13.0),

              //---------------------------------------------------------------- TIEMPO
                const Text(
                  'Tiempo en estado de adopción',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15.0,
                  ),
                ),
                SizedBox(
                  height: 38,
                  child:
                    Row(
                      children: [
                        Flexible(
                          child: TextFormField(
                            controller: _yearsControllerTiempo,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              labelText: 'Años',
                              hintText: '0-12',
                            ),
                            validator: (value) {
                              final years = int.tryParse(value ?? '');
                              if (years == null || years < 0 || years > 25) {
                                return 'Ingresa un valor entre 0 y 25';
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
                        //const SizedBox(width: 16.0),
                        Flexible(
                          child: TextFormField(
                            controller: _monthsControllerTiempo,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              labelText: 'Meses',
                              hintText: '0-11',
                            ),
                            validator: (value) {
                              final months = int.tryParse(value ?? '');
                              if (months == null || months < 0 || months > 12) {
                                return 'Ingresa un valor entre 0 y 12';
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
                ),
              //---------------------------------------------------------------- MICROCHIP
                CheckboxListTile(
                  title: const Text('Microchip',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15.0),),
                  value: _microchip,
                  onChanged: (value) {
                    setState(() {
                      _microchip = value;
                    });
                  },
                ),
              //---------------------------------------------------------------- BOTÓN
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState?.validate() == true) {
                      // Aquí tendrían que mandarse los datos al modelo
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      fixedSize: Size(90, 40),
                    ),
                    child: Text('Enviar',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0),),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
  }
}







