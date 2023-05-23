import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:google_fonts/google_fonts.dart';

class BarChartData {
  final String category;
  final int value;

  BarChartData(this.category, this.value);
}

class Opcion4Detalles extends StatelessWidget {
  final dynamic centro;

  Opcion4Detalles({required this.centro});

  @override
  Widget build(BuildContext context) {
    final data = [
      BarChartData('Capacidad', centro['Capacidad']),
      BarChartData('Ocupación', centro['Ocupacion']),
    ];


    final capacidad = centro['Capacidad'];
    final ocupacion = centro['Ocupacion'];

    double porcentajeOcupacion = (ocupacion / capacidad) * 100;


    final series = [
      charts.Series<BarChartData, String>(
          id: 'Centro',
          data: data,
          domainFn: (BarChartData entry, _) => entry.category,
          measureFn: (BarChartData entry, _) => entry.value,
          // Color de las barras
          colorFn: (BarChartData entry, _) {
            if (entry.category == 'Capacidad') {
              return charts.MaterialPalette.gray.shadeDefault;
            } else {
              if (entry.value <= centro['Capacidad'] - 20) {
                return charts.MaterialPalette.green.shadeDefault;
              } else if (entry.value <= centro['Capacidad']) {
                return charts.MaterialPalette.yellow.shadeDefault;
              } else {
                return charts.MaterialPalette.red.shadeDefault;
              }
            }
          },
          // Texto dentro de las barras
          labelAccessorFn: (BarChartData entry, _) {
            if (entry.category == 'Capacidad') {
              return '    Capacidad máxima: ${centro['Capacidad']}';
            } else {
              return '    Ocupación: ${centro['Ocupacion']} (${porcentajeOcupacion.toStringAsFixed(2)}%)';
            }
          }

      ),
    ];

    final chart = charts.BarChart(
      series,
      animate: true,
      barGroupingType: charts.BarGroupingType.grouped, // Barras agrupadas
      vertical: false, // Barras horizontales

      domainAxis: charts.OrdinalAxisSpec(
        renderSpec: charts.NoneRenderSpec(), // Ocultar las etiquetas y líneas del eje X
      ),


    );

    final chartWidget = Container(
      height: 200.0,
      child: chart,
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Detalles del centro',style: GoogleFonts.montserrat(),),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 17.0), // Ajusta los márgenes laterales según sea necesario
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '${centro['Nombre']}'
              ,style: GoogleFonts.montserrat(fontSize: 18.0, // Tamaño de fuente deseado
               fontWeight: FontWeight.bold,),
                textAlign: TextAlign.center, // Centrar el texto
              ),
              SizedBox(height: 7.0),
              Text('(${centro['Categoria']})'
                  ,style: GoogleFonts.montserrat(),),
              SizedBox(height: 20.0),
              Text(
                '${centro['Direccion']}',
                textAlign: TextAlign.center,
                style: GoogleFonts.montserrat(),
              ),
              SizedBox(height: 20.0),
              chartWidget, // GRÁFICO
              SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 10,
                    height: 10,
                    color: Colors.green,
                  ),
                  SizedBox(width: 5.0),
                  Text('Ocupación baja',style: GoogleFonts.montserrat(fontSize: 13),),
                  SizedBox(width: 20.0),
                  Container(
                    width: 10,
                    height: 10,
                    color: Colors.yellow,
                  ),
                  SizedBox(width: 5.0),
                  Text('Ocupación alta',style: GoogleFonts.montserrat(fontSize: 13),),
                  SizedBox(width: 20.0),
                  Container(
                    width: 10,
                    height: 10,
                    color: Colors.red,
                  ),
                  SizedBox(width: 5.0),
                  Text('Saturada',style: GoogleFonts.montserrat(fontSize: 13),),
                ],
              ),



              SizedBox(height: 40.0),
              Container(
                width: double.infinity, // Ancho completo de la pantalla
                color: Colors.transparent, // Fondo transparente
                child: Center(
                  child: Table(
                    defaultColumnWidth: IntrinsicColumnWidth(),
                    children: [
                      TableRow(
                        children: [
                          TableCell(
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Icon(
                                Icons.phone,
                                size: 20.0,
                              ),
                            ),
                          ),
                          TableCell(
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                '${centro['Telefono']}',
                                style: GoogleFonts.montserrat(fontSize: 13),),
                            ),
                          ),
                        ],
                      ),
                      TableRow(
                        children: [
                          TableCell(
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Icon(
                                Icons.language,
                                size: 20.0,
                              ),
                            ),
                          ),
                          TableCell(
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                '${centro['URL']}',
                                style: GoogleFonts.montserrat(fontSize: 13),),
                            ),
                          ),
                        ],
                      ),
                      TableRow(
                        children: [
                          TableCell(
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Icon(
                                Icons.facebook,
                                size: 20.0,
                              ),
                            ),
                          ),
                          TableCell(
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                '${centro['Facebook']}',
                                style: GoogleFonts.montserrat(fontSize: 13),
                              ),
                            ),
                          ),
                        ],
                      ),
                      // Agrega más filas según tus datos
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20.0),

            ],
          ),
        ),
      ),
    );
  }
}
