import 'package:app_tfg/screens/opcion4_detalles.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'dart:convert';


// CAMBIAR LAS IP AQUIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII



class Opcion4Listado extends StatefulWidget {
  @override
  _Opcion4ListadoState createState() => _Opcion4ListadoState();
}

class _Opcion4ListadoState extends State<Opcion4Listado> {
  int currentPage = 1;
  int itemsPerPage = 5; // Número de elementos por página
  List<dynamic> allData = [];

  @override
  void initState() {
    super.initState();
    fetchData(); // Llama al método fetchData() para obtener todos los datos
  }

  Future<void> fetchData() async {
    try {
      final response =
      await Dio().get('http://192.168.8.121:8000/enviarcentros/');

      if (response.statusCode == 200) {
        // Decodificar la respuesta JSON
        List<dynamic> data = response.data;
        setState(() {
          allData = data;
        });
      } else {
        throw Exception('Error al obtener los datos del dataframe');
      }
    } catch (e) {
      throw Exception('Error de conexión: $e');
    }
  }

  List<dynamic> getCurrentPageData() {
    final int startIndex = (currentPage - 1) * itemsPerPage;
    final int endIndex = startIndex + itemsPerPage;
    return allData.sublist(startIndex, endIndex);
  }

  void nextPage() {
    final int totalPages = (allData.length / itemsPerPage).ceil();
    if (currentPage < totalPages) {
      setState(() {
        currentPage++;
      });
    }
  }

  void previousPage() {
    if (currentPage > 1) {
      setState(() {
        currentPage--;
      });
    }
  }

  void navigateToDetalleCentro(dynamic centro) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Opcion4Detalles(centro: centro),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<dynamic> currentPageData = getCurrentPageData();
    final int totalPages = (allData.length / itemsPerPage).ceil();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Listado de centros'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          SizedBox(height: 10), // Espacio entre el AppBar y el primer elemento
          Expanded(
            child: GridView.count(
              crossAxisCount: 1, // Cambia a 1 para que sea una columna
              childAspectRatio: 4, // Ajusta el aspect ratio para que las celdas tengan el mismo tamaño
              children: currentPageData.map((item) {
                return GestureDetector(
                  onTap: () => navigateToDetalleCentro(item),
                  child: Container(
                    margin: EdgeInsets.all(8),
                    color: Colors.grey[300],
                    child: ListTile(
                      title: Text(item['Nombre'] ?? ''),
                      subtitle: Text(item['Direccion']?.toString() ?? ''),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: previousPage,
              ),
              Text('Página $currentPage de $totalPages'), // Mostrar el número de página y el total
              IconButton(
                icon: Icon(Icons.arrow_forward),
                onPressed: nextPage,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

