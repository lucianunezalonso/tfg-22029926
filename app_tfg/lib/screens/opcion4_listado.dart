import 'package:app_tfg/screens/opcion4_detalles.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'package:app_tfg/screens/GlobalVariable.dart';

class Opcion4Listado extends StatefulWidget {
  @override
  _Opcion4ListadoState createState() => _Opcion4ListadoState();
}

class ListItem {
  String title;
  String subtitle;
  bool isFavorite;

  ListItem({
    required this.title,
    required this.subtitle,
    this.isFavorite = false,
  });
}

class _Opcion4ListadoState extends State<Opcion4Listado> {
  int currentPage = 1;
  int itemsPerPage = 5; // Número de elementos por página
  List<dynamic> allData = [];
  bool isLoading = true; // Estado para controlar si los datos se están cargando

  bool showFavorites = false;

  List<ListItem> favoriteItems = [];

  @override
  void initState() {
    super.initState();
    fetchData(); // Llama al método fetchData() para obtener todos los datos
  }

  Future<void> fetchData() async {
    try {
      final response = await Dio().get(
          'http://${GlobalVariable().ip}:8000/enviarcentros/');

      if (response.statusCode == 200) {
        // Decodificar la respuesta JSON
        List<dynamic> data = response.data;
        setState(() {
          allData = data;
          isLoading =
          false; // Los datos se cargaron correctamente, cambiar isLoading a false
        });
      } else {
        throw Exception('Error al obtener los datos del dataframe');
      }
    } catch (e) {
      throw Exception('Error de conexión: $e');
    }
  }

  List<ListItem> getCurrentPageData() {
    final int startIndex = (currentPage - 1) * itemsPerPage;
    final int endIndex = startIndex + itemsPerPage;

    List<ListItem> itemsToShow = allData.sublist(startIndex, endIndex).map((item) {
      return ListItem(
        title: item['Nombre'] ?? '',
        subtitle: item['Direccion']?.toString() ?? '',
        isFavorite: favoriteItems.any((favoriteItem) => favoriteItem.title == item['Nombre']),
      );
    }).toList();

    if (showFavorites) {
      itemsToShow = itemsToShow.where((item) => item.isFavorite).toList();
    }

    return itemsToShow;
  }

  void toggleFavorite(ListItem item) {
    setState(() {
      item.isFavorite = !item.isFavorite;

      final index = allData.indexOf(item);
      if (index != -1) {
        allData[index].isFavorite = item.isFavorite;
      }

      if (item.isFavorite) {
        favoriteItems.add(item);
      } else {
        favoriteItems.removeWhere((favoriteItem) => favoriteItem.title == item.title);
      }
    });
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

  void navigateToDetalleCentro(ListItem item) {
    setState(() {
      item.isFavorite = !item.isFavorite;
      if (item.isFavorite) {
        favoriteItems.add(item);
      } else {
        favoriteItems.remove(item);
      }
    });

    // Navega a la pantalla de detalle del centro
    // ...
  }

  @override
  Widget build(BuildContext context) {
    final int totalPages = (allData.length / itemsPerPage).ceil();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Listado de centros'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(showFavorites ? Icons.favorite : Icons.favorite_border),
            onPressed: () {
              setState(() {
                showFavorites = !showFavorites;
              });
            },
          ),
        ],
      ),
      body: Column(
        children: [
          SizedBox(height: 10),
          Expanded(
            child: allData.isNotEmpty
                ? GridView.count(
              crossAxisCount: 1,
              childAspectRatio: 4,
              children: getCurrentPageData().map((item) {
                return GestureDetector(
                  onTap: () => navigateToDetalleCentro(item),
                  child: Container(
                    margin: EdgeInsets.all(8),
                    color: Colors.grey[300],
                    child: ListTile(
                      title: Text(item.title),
                      subtitle: Text(item.subtitle),
                      trailing: IconButton(
                        icon: Icon(
                          item.isFavorite ? Icons.favorite : Icons.favorite_border,
                        ),
                        onPressed: () {
                          setState(() {
                            toggleFavorite(item);
                          });
                        },
                      ),
                    ),
                  ),
                );
              }).toList(),
            )
                : Center(
              child: CircularProgressIndicator(),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: previousPage,
              ),
              Text('Página $currentPage de $totalPages'),
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
