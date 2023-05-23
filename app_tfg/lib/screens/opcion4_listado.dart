import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:app_tfg/screens/GlobalVariable.dart';
import 'package:app_tfg/screens/mapa.dart';
import 'package:app_tfg/screens/opcion4_detalles.dart';
import 'package:google_fonts/google_fonts.dart';


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

class Opcion4Listado extends StatefulWidget {
  @override
  _Opcion4ListadoState createState() => _Opcion4ListadoState();
}

class _Opcion4ListadoState extends State<Opcion4Listado> {
  int currentPage = 1;
  int itemsPerPage = 5; // Número de elementos por página
  List<dynamic> allData = [];
  bool isLoading = true; // Estado para controlar si los datos se están cargando

  bool showFavorites = false;

  List<ListItem> favoriteItems = [];

  bool isMapLoading = false;

  @override
  void initState() {
    super.initState();
    fetchData(); // Llama al método fetchData() para obtener todos los datos
  }

  Future<void> fetchData() async {
    try {
      final response = await Dio().get('http://${GlobalVariable().ip}:8000/enviarcentros/');

      if (response.statusCode == 200) {
        // Decodificar la respuesta JSON
        List<dynamic> data = response.data;
        setState(() {
          allData = data;
          isLoading = false; // Los datos se cargaron correctamente, cambiar isLoading a false
        });
      } else {
        throw Exception('Error al obtener los datos del dataframe');
      }
    } catch (e) {
      throw Exception('Error de conexión: $e');
    }
  }

  List<ListItem> getCurrentPageData() {
    List<ListItem> itemsToShow;

    if (showFavorites) {
      final int startIndex = (currentPage - 1) * itemsPerPage;
      final int endIndex = startIndex + itemsPerPage;
      if (startIndex >= favoriteItems.length) {
        itemsToShow = [];
      } else {
        itemsToShow = favoriteItems.sublist(startIndex, endIndex > favoriteItems.length ? favoriteItems.length : endIndex);
      }
    } else {
      final int startIndex = (currentPage - 1) * itemsPerPage;
      final int endIndex = startIndex + itemsPerPage;


      if (isSearching) {
        itemsToShow = filteredCentros.sublist(startIndex, endIndex > filteredCentros.length ? filteredCentros.length : endIndex).map((item) {
          final capacidad = item['Capacidad'];
          final ocupacion = item['Ocupacion'];

          double porcentajeOcupacion = (ocupacion / capacidad) * 100;

          return ListItem(

            title: item['Nombre'] ?? '',
            subtitle: '${porcentajeOcupacion.toStringAsFixed(2)}% de la capacidad máxima',
            isFavorite: favoriteItems.any((favoriteItem) => favoriteItem.title == item['Nombre']),
          );
        }).toList();
      } else if (isFiltered) {
        itemsToShow = filteredData.sublist(startIndex, endIndex > filteredData.length ? filteredData.length : endIndex).map((item) {
          final capacidad = item['Capacidad'];
          final ocupacion = item['Ocupacion'];

          double porcentajeOcupacion = (ocupacion / capacidad) * 100;

          return ListItem(
            title: item['Nombre'] ?? '',
            subtitle: '${porcentajeOcupacion.toStringAsFixed(2)}% de la capacidad máxima',
            isFavorite: favoriteItems.any((favoriteItem) => favoriteItem.title == item['Nombre']),
          );
        }).toList();
      } else {
        itemsToShow = allData.sublist(startIndex, endIndex > allData.length ? allData.length : endIndex).map((item) {
          final capacidad = item['Capacidad'];
          final ocupacion = item['Ocupacion'];

          double porcentajeOcupacion = (ocupacion / capacidad) * 100;

          return ListItem(
            title: item['Nombre'] ?? '',
            subtitle: '${porcentajeOcupacion.toStringAsFixed(2)}% de la capacidad máxima',
            isFavorite: favoriteItems.any((favoriteItem) => favoriteItem.title == item['Nombre']),
          );
        }).toList();
      }
    }
    return itemsToShow;
  }


  void toggleFavorite(ListItem item) {
    setState(() {
      item.isFavorite = !item.isFavorite;

      final index = allData.indexOf(item);
      if (index != -1) {
        allData[index]['isFavorite'] = item.isFavorite;
      }

      if (item.isFavorite) {
        if (!favoriteItems.contains(item)) {
          favoriteItems.add(item);
        }
      } else {
        favoriteItems.removeWhere((favoriteItem) => favoriteItem.title == item.title);
      }
    });
  }

  int getTotalPages() {
    if (showFavorites) {
      return (favoriteItems.length / itemsPerPage).ceil();
    } else {
      if (isSearching) {
        return (filteredCentros.length / itemsPerPage).ceil();
      } else if (isFiltered) {
        return (filteredData.length / itemsPerPage).ceil();
      } else {
        return (allData.length / itemsPerPage).ceil();
      }
    }
  }


  void nextPage() {
    final int totalPages = getTotalPages();
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
    final centro = allData.firstWhere((element) => element['Nombre'] == item.title);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Opcion4Detalles(centro: centro,),
      ),
    );
  }

  void _navigateToMapScreen() {
    setState(() {
      isMapLoading = true;
    });

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Mapa(centros: allData),
      ),
    ).then((_) {
      setState(() {
        isMapLoading = false;
      });
    });
  }


  // FUNCIÓN PARA BÚSQUEDA
  String searchQuery = '';

  void showSearchDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Buscar por nombre',style: GoogleFonts.montserrat(),),
          content: TextField(
            decoration: InputDecoration(
              labelText: 'Introduce el nombre del centro',
              labelStyle: GoogleFonts.montserrat(fontSize: 13),
            ),
            onChanged: (value) {
              setState(() {
                searchQuery = value;
              });
            },
          ),
          actions: [
            TextButton(
              child: Text('Buscar',style: GoogleFonts.montserrat(),),
              onPressed: () {
                applySearchFilter();
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Cancelar',style: GoogleFonts.montserrat(),),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  List<dynamic> filteredCentros = []; // Variable para almacenar los centros filtrados

  bool isSearching = false; // Variable para indicar si se está realizando una búsqueda

  void applySearchFilter() {
    setState(() {
      filteredCentros = allData.where((centro) => centro['Nombre'].toString().toLowerCase().contains(searchQuery.toLowerCase())).toList();
      isSearching = true; // Se ha aplicado el filtro de búsqueda
    });
  }

  // FILTROS

  String selectedAutonomousCommunity = 'Todas'; // Valor inicial: 'Todas'
  String selectedCategory = 'Todas'; // Valor inicial: 'Todas'

  void showFilterDialog() {
    List<String> autonomousCommunities = []; // Lista para almacenar los valores únicos de CCAA
    List<String> categories = []; // Lista para almacenar los valores únicos de categorías

    // Obtener los valores únicos de CCAA y categorías
    for (var centro in allData) {
      String ccaa = centro['CCAA'];
      String category = centro['Categoria'];

      if (!autonomousCommunities.contains(ccaa)) {
        autonomousCommunities.add(ccaa);
      }

      if (!categories.contains(category)) {
        categories.add(category);
      }
    }

    // Agregar la opción "Todas" al inicio de autonomousCommunities y categories
    autonomousCommunities.insert(0, 'Todas');
    categories.insert(0, 'Todas');

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Filtros',style: GoogleFonts.montserrat(),),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // FILTRO DE COMUNIDAD AUTÓNOMA
              DropdownButtonFormField<String>(
                value: selectedAutonomousCommunity,
                items: autonomousCommunities.map((ccaa) {
                  return DropdownMenuItem(
                    value: ccaa,
                    child: Text(ccaa,style: GoogleFonts.montserrat(),),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedAutonomousCommunity = value!;
                  });
                },
                decoration: InputDecoration(
                  labelText: 'Comunidad Autónoma',
                  labelStyle:  GoogleFonts.montserrat(),
                ),
              ),
              // FILTRO DE CATEGORÍA
              DropdownButtonFormField<String>(
                value: selectedCategory,
                items: categories.map((category) {
                  return DropdownMenuItem(
                    value: category,
                    child: Text(category,style: GoogleFonts.montserrat(),),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedCategory = value!;
                  });
                },
                decoration: InputDecoration(
                  labelText: 'Categoría',
                  labelStyle: GoogleFonts.montserrat(),
                ),
              ),
              // Agrega más campos de filtro según tus necesidades
            ],
          ),
          actions: [
            TextButton(
              child: Text('Aplicar',style: GoogleFonts.montserrat(),),
              onPressed: () {
                setState(() {
                  applyFilter();
                });

                Navigator.of(context).pop(); // Cierra el diálogo
              },
            ),
          ],
        );
      },
    );
  }

  List<dynamic> filteredData = []; // Variable para almacenar los centros filtrados
  bool isFiltered = false;

  void applyFilter() {
    setState(() {
      filteredData = allData.where((centro) {
        bool byAutonomousCommunity = selectedAutonomousCommunity == 'Todas' ||
            centro['CCAA'].toLowerCase() == selectedAutonomousCommunity!.toLowerCase();

        bool byCategory = selectedCategory == 'Todas' ||
            centro['Categoria'].toLowerCase() == selectedCategory!.toLowerCase();

        // Mostrar todos los centros si se selecciona "Todas" en ambos filtros
        if (selectedAutonomousCommunity == 'Todas' && selectedCategory == 'Todas') {
          return true;
        }

        // Filtrar por la comunidad autónoma si se selecciona una categoría específica y todas las CCAA
        if (selectedAutonomousCommunity == 'Todas' && selectedCategory != 'Todas') {
          return byCategory;
        }

        // Filtrar por la categoría si se selecciona una CCAA específica y todas las categorías
        if (selectedAutonomousCommunity != 'Todas' && selectedCategory == 'Todas') {
          return byAutonomousCommunity;
        }

        // Filtrar por la comunidad autónoma y categoría seleccionadas
        return byAutonomousCommunity && byCategory;
      }).toList();

      isFiltered = true;
      // Reiniciar la paginación cuando se aplican los filtros
      currentPage = 1;
    });
  }










  // CÓDIGO DEL WIDGET----------------------------------------------------------

  Widget build(BuildContext context) {
    final int totalPages = getTotalPages();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Listado de centros',style: GoogleFonts.montserrat(),),
        centerTitle: true,
      ),
      body: Column(
        children: [
          SizedBox(height: 10),
          Container(
            color: Colors.grey[200], // Color de fondo de la barra
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    showSearchDialog();
                  },
                ),
                IconButton(
                  icon: Icon(Icons.filter_list),
                  onPressed: () {
                    showFilterDialog();
                  },
                ),
                IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () {
                    setState(() {
                      showFavorites = false;
                      isSearching = false;
                      isFiltered= false;
                      currentPage = 1;
                      searchQuery = '';
                    });
                  },
                ),

                IconButton(
                  icon: Icon(Icons.map),
                  onPressed: isMapLoading ? null : _navigateToMapScreen,
                ),

                IconButton(
                  icon: Icon(showFavorites ? Icons.favorite : Icons.favorite_border),
                  onPressed: () {
                    setState(() {
                      showFavorites = !showFavorites;
                      currentPage = 1; // Reiniciar la página cuando se cambia el filtro
                    });
                  },
                ),
              ],
            ),
          ),


          Expanded(
            child: isLoading
                ? Center(
              child: CircularProgressIndicator(),
            )
                : GridView.count(
              crossAxisCount: 1,
              childAspectRatio: 4,
              children: getCurrentPageData().map((item) {
                return GestureDetector(
                  onTap: () => navigateToDetalleCentro(item),
                  child: Container(
                    margin: EdgeInsets.all(8),
                    color: Colors.grey[300],
                    child: ListTile(
                      title: Text(item.title,style: GoogleFonts.montserrat(),),
                      subtitle: Text(item.subtitle,style: GoogleFonts.montserrat(),),
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
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: previousPage,
              ),
              Text('Página $currentPage de $totalPages',style: GoogleFonts.montserrat(),),
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
