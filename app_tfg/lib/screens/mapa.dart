import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class Mapa extends StatelessWidget {
  final List<dynamic> centros;

  Mapa({required this.centros});

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      options: MapOptions(
        center: LatLng(40.4168, -3.7038), // Ubicación inicial del mapa (centro de España)
        zoom: 6.0, // Nivel de zoom inicial del mapa
      ),
      layers: [
        TileLayerOptions(
          urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
          subdomains: ['a', 'b', 'c'],
        ),
        MarkerLayerOptions(
          markers: centros
              .map(
                (centro) => Marker(
              width: 40.0,
              height: 40.0,
              point: LatLng(centro['Latitud'], centro['Longitud']),
              builder: (ctx) => Container(
                child: Icon(Icons.location_on, color: Colors.black),
              ),
            ),
          )
              .toList(),
        ),
      ],
    );
  }
}
