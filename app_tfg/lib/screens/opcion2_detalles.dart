import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:app_tfg/screens/GlobalVariable.dart';
import 'package:google_fonts/google_fonts.dart';


class Opcion2Detalles extends StatelessWidget {
  final dynamic animal;

  Opcion2Detalles({required this.animal});

  // SELECTOR DE IMAGEN EN FUNCIÓN DE LA RAZA

  String getFotoRaza(String raza) {
    print(raza);
    switch (raza) {
      case 'Mestizo':
        return 'assets/images/mestizo.jpg';
      case 'Desconocida':
        return 'assets/images/mestizo.jpg';
      case 'Pastor Belga':
        return 'assets/images/pastor_belga.jpg';
      case 'Cruce Pastor Belga':
        return 'assets/images/pastor_belga.jpg';
      case 'Cruce Mastín':
        return 'assets/images/mastin.jpg';
      case 'Mastín':
        return 'assets/images/mastin.jpg';
      case 'Yorkshire Terrier':
        return 'assets/images/yorkshire.jpg';
      case 'Podenco':
        return 'assets/images/podenco.jpg';
      case 'Cruce Podenco':
        return 'assets/images/podenco.jpg';
      case 'Cruce Pointer':
        return 'assets/images/pointer.jpg';
      case 'Cruce Pastor Alemán':
        return 'assets/images/pastor_aleman.jpg';
      case 'Pastor Alemán':
        return 'assets/images/pastor_aleman.jpg';


      case 'Cruce Sharpei':
        return 'assets/images/sharpei.jpg';
      case 'Galgo':
        return 'assets/images/galgo.jpg';
      case 'Cruce Bodeguero':
        return 'assets/images/bodeguero.jpg';
      case 'Bodeguero':
        return 'assets/images/bodeguero.jpg';
      case 'Cruce Bull Terrier':
        return 'assets/images/bull_terrier.jpg';
      case 'Cruce Fox Terrier':
        return 'assets/images/fox_terrier.jpg';
      case 'Bretón Español':
        return 'assets/images/breton.jpg';
      case 'Cruce Labrador':
        return 'assets/images/labrador.jpg';
      case 'Cruce PPP':
        return 'assets/images/cruce_ppp.jpg';
      case 'Bichón Maltés':
        return 'assets/images/bichon_maltes.jpg';
      case 'Cruce Basenji':
        return 'assets/images/basenji.jpg';
      case 'Cruce Husky':
        return 'assets/images/husky.jpg';
      case 'Cruce Pastor del Cáucaso':
        return 'assets/images/pastor_caucaso.jpg';
      case 'Perro de agua':
        return 'assets/images/perro_agua.jpg';


      default: // Ruta de la foto por defecto (gato)
        return 'assets/images/gato.jpg';
    }
  }

  // COJO LOS DATOS DE LOS CENTROS
  Future<dynamic> fetchData() async {
    try {
      final response = await Dio().get('http://${GlobalVariable().ip}:8000/enviarcentros/');
      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw Exception('Error al obtener los datos del dataframe');
      }
    } catch (e) {
      throw Exception('Error de conexión: $e');
    }
  }




  @override
  Widget build(BuildContext context) {
    final String fotoRaza = getFotoRaza(animal['Raza']?.toString() ?? '');

    return FutureBuilder<dynamic>(
      future: fetchData(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final data = snapshot.data as List<dynamic>;
          final centro = data.firstWhere((item) => item['id_centro'] == animal['id_centro'], orElse: () => null);
          final nombreCentro = centro != null ? centro['Nombre']?.toString() ?? '' : '';
          final comunidadAutonoma = centro != null ? centro['CCAA']?.toString() ?? '' : '';

          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.black,
              title: Text('Detalles del Animal',style: GoogleFonts.montserrat(),),
              centerTitle: true,
            ),
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  height: 250,
                  color: Colors.grey,
                  child: Image.asset(
                    fotoRaza,
                    fit: BoxFit.cover,
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(25.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 10),
                        Text(
                          '${animal['Nombre'] ?? ''}',
                          style: GoogleFonts.montserrat(fontSize: 30,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 10),
                        Text(
                          '${animal['Raza']?.toString() ?? ''}',
                          style: GoogleFonts.montserrat(fontSize: 16),
                        ),
                        SizedBox(height: 18),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 170,
                              height: 70,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.grey[300],
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  if (animal['Sexo'] == 'Macho')
                                    Icon(
                                      Icons.male,
                                      color: Colors.black,
                                    )
                                  else if (animal['Sexo'] == 'Hembra')
                                    Icon(
                                      Icons.female,
                                      color: Colors.black,
                                    ),
                                  SizedBox(width: 10),
                                  Text(
                                    '${animal['Sexo'] ?? ''}',
                                    style: GoogleFonts.montserrat(fontSize: 18,
                                        color: Colors.black),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: 20),
                            Container(
                              width: 170,
                              height: 70,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.grey[300],
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.cake,
                                    color: Colors.black,
                                  ),
                                  SizedBox(width: 10),
                                  Text(
                                    '${animal['Edad'] ?? ''}',
                                    style: GoogleFonts.montserrat(fontSize: 18,color: Colors.black),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        Text(
                          'Está en...',
                          style: GoogleFonts.montserrat(fontSize: 16),
                        ),
                        SizedBox(height: 8),
                        Text(
                          '$nombreCentro (${comunidadAutonoma})',
                          style: GoogleFonts.montserrat(fontSize: 16,color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text('Error al cargar los datos: ${snapshot.error}',
              style: GoogleFonts.montserrat(),
            ),
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

}


