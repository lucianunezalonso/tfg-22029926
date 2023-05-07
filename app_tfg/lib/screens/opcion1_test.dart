import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';

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


  int _years_edad = 0;
  int _months_edad = 0;

  int _years_tiempo = 0;
  int _months_tiempo = 0;

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

  List<dynamic> variablesUsuario1 = [];


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
                                _years_edad = int.tryParse(value ?? '') ?? 0;
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
                                _months_edad = int.tryParse(value ?? '') ?? 0;
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
                                _years_tiempo = int.tryParse(value ?? '') ?? 0;
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
                                _months_tiempo = int.tryParse(value ?? '') ?? 0;
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
                      // SE MANDAN LOS DATOS AL MODELO
                          /*
                          // Llamar a la función para enviar los datos al backend
                          mandarVariables({
                            'especie': _especie.toString(),
                            'raza': _raza.toString(),
                            'sexo': _sexo.toString(),
                            'tamano': _tamano.toString(),
                            'microchip': _microchip.toString(),
                            'years_tiempo': _years_tiempo.toString(),
                            'months_tiempo': _months_tiempo.toString(),
                            'years_edad': _years_edad.toString(),
                            'months_edad': _months_edad.toString(),
                          });
                          */

                        String raza= _raza.toString();
                        String especie= _especie.toString();
                        String sexo= _sexo.toString();

                        mandarVariables({
                          'especie': especie,
                          'raza': raza,
                          'sexo': sexo,
                        });

                        /*
                        mandarVariables({
                          'especie': 'perro',
                          'raza': 'galgo',
                          'sexo': 'macho',
                        });

                         */

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

  // FUNCIÓN PARA MANDAR VARIABLES AL BACKEND

  /*
  Future<void> mandarVariables(List<dynamic> lista) async {
    final url = Uri.parse('http://localhost:8080/recogerdatos1/');

    final response = await http.post(
      url,
      body: lista,
    );

    if (response.statusCode == 200) {
      // La solicitud se realizó correctamente
      print('Datos enviados correctamente');
    } else {
      // Ocurrió un error en la solicitud
      print('Error al enviar los datos');
    }
  }

   */

  /*
  void mandarVariables(Map<String, String> variables) async {
    var url = 'http://localhost:8000/recogerdatos1';
    var response = await http.get(Uri.parse(url), body: variables);

    if (response.statusCode == 200) {
      // Éxito en la solicitud
      print('Solicitud enviada correctamente');
      print(response.body);
    } else {
      // Error en la solicitud
      print('Error en la solicitud');
      print(response.statusCode);
    }
  }
   */

  /*
  void mandarVariables(Map<String, String> variables) async {
    var url = 'http://localhost:8000/recogerdatos1?';

    // Concatenar los parámetros a la URL
    variables.forEach((key, value) {
      url += '$key=$value&';
    });

    var response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      // Éxito en la solicitud
      print('Solicitud enviada correctamente');
      print(response.body);
    } else {
      // Error en la solicitud
      print('Error en la solicitud');
      print(response.statusCode);
    }
  }

   */
   /*
  void mandarVariables(Map<String, String> variables) async {
    var baseUrl = 'localhost:8000';
    var path = '/recogerdatos1';

    var uri = Uri.http(baseUrl, path, variables);

    var response = await http.get(uri);

    if (response.statusCode == 200) {
      // Éxito en la solicitud
      print('Solicitud enviada correctamente');
      print(response.body);
    } else {
      // Error en la solicitud
      print('Error en la solicitud');
      print(response.statusCode);
    }
  }

    */
  void mandarVariables(Map<String, String> variables) async {

    var dio = Dio();

    var response = await dio.get('http://localhost:8000/recogerdatos1/', queryParameters: variables);

    if (response.statusCode == 200) {
      // Éxito en la solicitud
      print('Solicitud enviada correctamente');
      print(response.data);
    } else {
      // Error en la solicitud
      print('Error en la solicitud');
      print(response.statusCode);
    }
  }

}







