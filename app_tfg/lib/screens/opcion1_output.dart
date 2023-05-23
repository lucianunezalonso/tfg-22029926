import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Opcion1Output extends StatelessWidget {
  final List<dynamic> resultData;

  Opcion1Output({required this.resultData});

  @override
  Widget build(BuildContext context) {
    final firstPageData = resultData.sublist(0, 5); // Obtener los primeros 5 elementos

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Centros recomendados',style: GoogleFonts.montserrat(),),
        centerTitle: true,
      ),
      body: Center(
        child: ListView.builder(
          itemCount: firstPageData.length,
          itemBuilder: (context, index) {
            final item = firstPageData[index];
            final itemIndex = index + 1; // Obtener el número de índice real

            return ListTile(
              title: Text('$itemIndex. ${item['Nombre'] ?? ''}',style: GoogleFonts.montserrat(fontWeight: FontWeight.bold),),
              subtitle: Text(item['CCAA']?.toString() ?? '',style: GoogleFonts.montserrat(),),
            );
          },
        ),
      ),

    );
  }
}
