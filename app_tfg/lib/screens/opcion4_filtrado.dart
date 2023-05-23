import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:app_tfg/screens/GlobalVariable.dart';
import 'package:app_tfg/screens/opcion4_detalles.dart';

class ListItem {
  String title;
  String subtitle;

  ListItem({
    required this.title,
    required this.subtitle,
  });
}

class Opcion4Filtrado extends StatefulWidget {
  final List<dynamic> filteredCentros;

  Opcion4Filtrado({required this.filteredCentros});

  @override
  _Opcion4FiltradoState createState() => _Opcion4FiltradoState();
}

class _Opcion4FiltradoState extends State<Opcion4Filtrado> {
  int currentPage = 1;
  int itemsPerPage = 5; // Número de elementos por página
  List<ListItem> allItems = [];
  List<ListItem> currentPageItems = [];
  bool isLoading = true; // Estado para controlar si los datos se están cargando


  @override
  void initState() {
    super.initState();
    generateListItems(); // Generar la lista de ListItem a partir de los datos filtrados
  }

  void generateListItems() {
    allItems = widget.filteredCentros.map((centro) {
      return ListItem(
        title: centro['Nombre'],
        subtitle: centro['Direccion']?.toString() ?? '',
      );
    }).toList();

    // Cargar los elementos de la primera página
    currentPageItems = getCurrentPageItems();

    // Los datos se cargaron correctamente, cambiar isLoading a false
    setState(() {
      isLoading = false;
    });
  }

  List<ListItem> getCurrentPageItems() {
    final int startIndex = (currentPage - 1) * itemsPerPage;
    final int endIndex = startIndex + itemsPerPage;

    return allItems.sublist(startIndex, endIndex > allItems.length ? allItems.length : endIndex);
  }

  void nextPage() {
    final int totalPages = (allItems.length / itemsPerPage).ceil();
    if (currentPage < totalPages) {
      setState(() {
        currentPage++;
        currentPageItems = getCurrentPageItems();
      });
    }
  }

  void previousPage() {
    if (currentPage > 1) {
      setState(() {
        currentPage--;
        currentPageItems = getCurrentPageItems();
      });
    }
  }


  void navigateToDetalleCentro(ListItem item) {
    final centro = widget.filteredCentros.firstWhere((element) => element['Nombre'] == item.title);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Opcion4Detalles(centro: centro,),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final int totalPages = (allItems.length / itemsPerPage).ceil();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Listado de centros filtrados'),
        centerTitle: true,
      ),
      body: isLoading
          ? Center(
        child: CircularProgressIndicator(),
      )
          : Column(
        children: [
          SizedBox(height: 10),
          Expanded(
            child: GridView.count(
              crossAxisCount: 1,
              childAspectRatio: 4,
              children: currentPageItems.map((item) {
                return GestureDetector(
                  onTap: () => navigateToDetalleCentro(item),
                  child: Container(
                    margin: EdgeInsets.all(8),
                    color: Colors.grey[300],
                    child: ListTile(
                      title: Text(item.title),
                      subtitle: Text(item.subtitle),

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
                disabledColor: Colors.grey,
              ),
              Text(
                'Página $currentPage de $totalPages',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              IconButton(
                icon: Icon(Icons.arrow_forward),
                onPressed: nextPage,
                disabledColor: Colors.grey,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
