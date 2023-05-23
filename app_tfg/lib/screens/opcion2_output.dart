import 'package:app_tfg/screens/opcion1_test.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:app_tfg/screens/opcion2_detalles.dart';

class Opcion2Output extends StatefulWidget {
  final List<dynamic> resultData;

  Opcion2Output({required this.resultData});

  @override
  _Opcion2OutputState createState() => _Opcion2OutputState();
}

class _Opcion2OutputState extends State<Opcion2Output> {
  final int itemsPerPage = 6;
  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    final totalItems = widget.resultData.length;
    final totalPages = (totalItems / itemsPerPage).ceil();
    final startIndex = currentPage * itemsPerPage;
    final endIndex = (startIndex + itemsPerPage) < totalItems
        ? (startIndex + itemsPerPage)
        : totalItems;
    final currentPageData = widget.resultData.sublist(startIndex, endIndex);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Animales recomendados'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              itemCount: currentPageData.length,
              itemBuilder: (context, index) {
                final item = currentPageData[index];
                final itemIndex = startIndex + index + 1;

                return GestureDetector(
                  onTap: () {
                    // Navegar a la pantalla personalizada para cada elemento
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Opcion2Detalles(
                          animal: item,
                        ),
                      ),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    margin: EdgeInsets.all(7.0),
                    child: ListTile(
                      title: Text('$itemIndex. ${item['Nombre'] ?? ''}'),
                      subtitle: Text(item['Raza']?.toString() ?? ''),
                    ),
                  ),
                );
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: currentPage > 0
                    ? () {
                  setState(() {
                    currentPage--;
                  });
                }
                    : null,
              ),
              Text('${currentPage + 1}/$totalPages'),
              IconButton(
                icon: Icon(Icons.arrow_forward),
                onPressed: currentPage < totalPages - 1
                    ? () {
                  setState(() {
                    currentPage++;
                  });
                }
                    : null,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

