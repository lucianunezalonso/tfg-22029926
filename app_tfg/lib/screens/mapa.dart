import 'package:app_tfg/screens/opcion4_filtrado.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:google_fonts/google_fonts.dart';

class Mapa extends StatefulWidget {
  final List<dynamic> centros;

  Mapa({required this.centros});

  @override
  _MapaState createState() => _MapaState();
}

class _MapaState extends State<Mapa> {
  final theme = ThemeData(
    textTheme: TextTheme(
      headline1: GoogleFonts.montserrat(fontWeight: FontWeight.bold),
      headline2: GoogleFonts.montserrat(fontStyle: FontStyle.italic),
    ),
  );

  List<LatLng> polygonPoints = []; // Puntos del polígono dibujado

  Set<Polygon> polygons = {};

  List<dynamic> centrosDentroPoligono = [];

  bool isAreaSelected = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: theme,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text('Mapa',
            style: GoogleFonts.montserrat(),),
        ),
        body: FlutterMap(
          options: MapOptions(
            center: LatLng(40.4168, -3.7038), // Ubicación inicial del mapa (centro de España)
            zoom: 5.2, // Nivel de zoom inicial del mapa
            onTap: (point) {
              setState(() {
                polygonPoints.add(point); // Agregar punto al polígono dibujado
              });
            },
          ),
          layers: [
            TileLayerOptions(
              urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
              subdomains: ['a', 'b', 'c'],
            ),
            MarkerLayerOptions(
              markers: widget.centros.map(
                    (centro) => Marker(
                  width: 40.0,
                  height: 40.0,
                  point: LatLng(centro['Latitud'], centro['Longitud']),
                  builder: (ctx) => Container(
                    child: Icon(Icons.location_on, color: Color(0xFFEE892F).withOpacity(0.3)),
                  ),
                ),
              ).toList(),
            ),

            // Área dibujada por el usuario
            PolylineLayerOptions(
              polylines: [
                Polyline(
                  points: polygonPoints,
                  strokeWidth: 2,
                  color: Colors.grey,
                ),
              ],
            ),
            PolygonLayerOptions(
              polygons: [
                Polygon(
                  points: polygonPoints,
                  color: Colors.grey.withOpacity(0.3),
                ),
              ],
            ),
          ],
        ),
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            FloatingActionButton(
              onPressed: () {
                setState(() {
                  polygonPoints = []; // Reiniciar puntos del polígono dibujado
                  isAreaSelected = false; // Restablecer el estado de la selección del área
                });
              },
              child: Icon(Icons.clear),
              backgroundColor: Colors.black,
            ),
            FloatingActionButton(
              onPressed: () {
                if (polygonPoints.isNotEmpty) {
                  List<dynamic> filteredCentros = [];
                  LatLngBounds bounds = LatLngBounds.fromPoints(polygonPoints);
                  for (var centro in widget.centros) {
                    LatLng punto = LatLng(centro['Latitud'], centro['Longitud']);
                    if (bounds.contains(punto)) {
                      filteredCentros.add(centro);
                    }
                  }
                  if (filteredCentros.isNotEmpty) {
                    // Realiza algo con los nombres de los centros dentro del polígono
                    print('Centros dentro del polígono:');
                    filteredCentros.forEach((centro) {
                      print(centro['Nombre']);
                    });

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Opcion4Filtrado(filteredCentros: filteredCentros),
                      ),
                    );

                  } else {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          content: Container(
                            width: 200, // Ancho personalizado
                            height: 100, // Alto personalizado
                            child: Column(
                              children: [
                                Text('No hay centros dentro del área seleccionado',
                                style: GoogleFonts.montserrat(),),
                                SizedBox(height: 10),
                                TextButton(
                                  child: Text(
                                    'Aceptar',
                                    style: GoogleFonts.montserrat(
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF6E896A),
                                        fontSize: 17
                                    ),
                                  ),

                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  }

                } else {
                  // No se ha seleccionado un área
                  // Seleccione el área deseada
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        content: Container(
                          width: 200, // Ancho personalizado
                          height: 90, // Alto personalizado
                          child: Column(
                            children: [
                              Text(' Seleccione el área deseada',
                            style: GoogleFonts.montserrat(),),
                              SizedBox(height: 10),
                              TextButton(
                                child: Text(
                                  'Aceptar',
                                  style: GoogleFonts.montserrat(
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF6E896A),
                                      fontSize: 17
                                  ),
                                ),

                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }
              },
              child: Icon(Icons.arrow_right_alt),
              backgroundColor: Colors.black,
            ),
          ],
        ),
      ),
    );
  }
}
