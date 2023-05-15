import 'package:app_tfg/screens/GlobalVariable.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:app_tfg/screens/opcion1_output.dart';
import 'package:app_tfg/screens/GlobalVariable.dart';




// CAMBIAR LAS IP AQUIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII

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
  List<dynamic> allData = [];
  List<dynamic> resultData = []; // Variable de instancia para almacenar los datos

  bool isLoading = false; // Estado para controlar si los datos se están cargando




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
                        decoration: InputDecoration(
                          labelText: _years_edad == 0 ? 'Años' : '',
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
                    Flexible(
                      child: TextFormField(
                        controller: _monthsControllerEdad,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: _months_edad == 0 ? 'Meses' : '',
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
                          decoration: InputDecoration(
                            labelText: _years_tiempo == 0 ? 'Años' : '',
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
                      Flexible(
                        child: TextFormField(
                          controller: _monthsControllerTiempo,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: _months_tiempo == 0 ? 'Meses' : '',
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

                        setState(() {
                          isLoading = true; // Mostrar indicador de carga
                        });

                        String raza= _raza.toString();
                        String especie= _especie.toString();
                        String sexo= _sexo.toString();
                        String tamano = _tamano.toString();
                        String microchip = _microchip.toString();
                        String years_tiempo= _years_tiempo.toString();
                        String months_tiempo= _months_tiempo.toString();
                        String years_edad= _years_edad.toString();
                        String months_edad= _months_edad.toString();


                        mandarVariables({
                          'especie': especie,
                          'raza': raza,
                          'sexo': sexo,
                          'tamano': tamano,
                          'microchip':microchip,
                          'years_tiempo':years_tiempo,
                          'months_tiempo':months_tiempo,
                          'years_edad':years_edad,
                          'months_edad':months_edad
                        });

                        setState(() {
                          isLoading = false; // Ocultar indicador de carga
                        });

                        /*
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => Opcion1Output(),
                          ),
                        );

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
                if (isLoading)
                  Container(
                    color: Colors.black.withOpacity(0.5),
                    child: Center(
                      child: CircularProgressIndicator(),
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
  Future mandarVariables(Map<String, dynamic> datos) async {
    var response = await Dio().get(
      "http://192.168.8.121:8000/recogerdatos1/",
      queryParameters: datos,
      options: Options(responseType: ResponseType.bytes),
    );

    assert(response.statusCode == 200);
    return response.data;
  }

   */

  Future mandarVariables(Map<String, dynamic> datos) async {
    try {


      final response = await Dio().get(
        "http://${GlobalVariable().ip}:8000/recogerdatos1/",
        queryParameters: datos
      );

      if (response.statusCode == 200) {
        // Decodificar la respuesta JSON
        List<dynamic> data = response.data;

        resultData = data;

        print(data);

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Opcion1Output(resultData: resultData),
          ),
        );
      } else {
        throw Exception('Error al obtener los datos del dataframe');
      }
    } catch (e) {
      throw Exception('Error de conexión: $e');
    }
  }

}







