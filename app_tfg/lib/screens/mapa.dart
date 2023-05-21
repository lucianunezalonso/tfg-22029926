import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class Mapa extends StatefulWidget {
  final List<dynamic> centros;

  Mapa({required this.centros});

  @override
  _MapaState createState() => _MapaState();
}

class _MapaState extends State<Mapa> {
  List<LatLng> polygonPoints = []; // Puntos del polígono dibujado

  Set<Polygon> polygons = {};

  Polygon? selectedPolygon; // Variable para almacenar el polígono dibujado

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Mapa'),
      ),
      body: FlutterMap(
        options: MapOptions(
          center: LatLng(40.4168, -3.7038), // Ubicación inicial del mapa (centro de España)
          zoom: 6.0, // Nivel de zoom inicial del mapa
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
                  child: Icon(Icons.location_on, color: Colors.black),
                ),
              ),
            ).toList(),
          ),
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            polygonPoints = []; // Reiniciar puntos del polígono dibujado
          });
        },
        child: Icon(Icons.clear),
        backgroundColor: Colors.black, // Establecer el color de fondo en gris

      ),
    );
  }
}