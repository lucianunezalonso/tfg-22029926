import 'package:app_tfg/screens/opcion1_test.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../screens/login_screen.dart';

import '../screens/opcion1_test.dart';
import '../screens/opcion2_test.dart';
import '../screens/opcion4_listado.dart';
import 'package:google_fonts/google_fonts.dart';

import '../helper/firebase_auth.dart';

class HomeScreen extends StatefulWidget {
  final User user;

  HomeScreen({required this.user});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late User _currentUser;
  bool isLoading= false;

  Future<void> fetchData() async {
    setState(() {
      isLoading = true; // Mostrar el círculo de carga
    });

    // Realizar la carga de datos

    setState(() {
      isLoading = false; // Ocultar el círculo de carga
    });
  }


  @override
  void initState() {
    _currentUser = widget.user;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    final theme = ThemeData(
      textTheme: TextTheme(
        headline1: GoogleFonts.montserrat(fontWeight: FontWeight.bold),
        headline2: GoogleFonts.montserrat(fontStyle: FontStyle.italic),
      ),
    );

    return MaterialApp(
      theme: theme,
      home: Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('AdoptionMovement',
          style: GoogleFonts.montserrat(),),

        centerTitle: true,
      ),

      body: WillPopScope(
        onWillPop: () async {
          final logout = await showDialog<bool>(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: new Text('Estás seguro?',
                  style: GoogleFonts.montserrat(),),
                content: new Text('Quieres cerrar sesión en la app',
                  style: GoogleFonts.montserrat(),),
                actionsAlignment: MainAxisAlignment.spaceBetween,
                actions: [
                  TextButton(
                    onPressed: () {
                      Logout();
                    },
                    child: Text('Sí',
                      style: GoogleFonts.montserrat(),),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context, false);
                    },
                    child: Text('No',
                      style: GoogleFonts.montserrat(),),
                  ),
                ],
              );
            },
          );
          return logout!;
        },


        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Center(
              child: Column(

                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '¡Hola ${_currentUser.displayName}!',
                    style: GoogleFonts.montserrat(
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 15.0),
                  Text('¿Qué quieres hacer hoy?',
                    style: GoogleFonts.montserrat(fontSize: 17.0),
                  ),
                  SizedBox(height: 20.0),
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => Opcion1Test(),
                        ),
                      );
                    },
                    icon: Icon(Icons.favorite_outline, size: 48),
                    label: RichText(
                      text: TextSpan(
                        style: TextStyle(fontSize: 20),
                        children: [
                          TextSpan(text: '¿Necesitas que un animal sea adoptado?\n',
                            style: GoogleFonts.montserrat(
                              fontSize: 19,
                              fontWeight: FontWeight.bold,
                            ),),
                          TextSpan(text: '\n', style: GoogleFonts.montserrat(
                            fontSize: 6,
                          )
                          ),
                          TextSpan(text: 'Te recomendamos a donde llevarlo', style: GoogleFonts.montserrat(
                            fontSize: 15,
                            )
                          ),
                        ],
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary:  Color(0xFFEE892F),
                      minimumSize: Size(double.infinity, 110),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),

                  SizedBox(height: 10.0),


                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => Opcion2Test(),
                        ),
                      );
                    },
                    icon: Icon(Icons.list_alt_sharp, size:48),
                    label: RichText(
                      text: TextSpan(
                        style: TextStyle(fontSize: 20),
                        children: [
                          TextSpan(text: 'Haz el test de compatibilidad\n',
                            style: GoogleFonts.montserrat(
                              fontSize: 19,
                              fontWeight: FontWeight.bold,
                            ),),
                          TextSpan(text: '\n', style: GoogleFonts.montserrat(
                            fontSize: 6,
                          )
                          ),
                          TextSpan(text: 'Conoce los animales que mejor se adaptan a tí', style: GoogleFonts.montserrat(
                            fontSize: 15,
                          )
                          ),
                        ],
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary:  Color(0xFFE0BB76),
                      minimumSize: Size(double.infinity, 110),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),

                  SizedBox(height: 10.0),

                  ElevatedButton.icon(
                    onPressed: () {
                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (BuildContext context) {
                          return Dialog(
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  CircularProgressIndicator(),
                                  SizedBox(height: 20),
                                  Text(
                                    'Cargando...',
                                    style: GoogleFonts.montserrat(fontSize: 16)

                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );

                      fetchData().then((_) {
                        Navigator.pop(context); // Cierra el diálogo de carga
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Opcion4Listado(),
                          ),
                        );
                      });
                    },
                    icon: Icon(Icons.home_outlined, size: 48),
                    label: RichText(
                      text: TextSpan(
                        style: TextStyle(fontSize: 20),
                        children: [
                          TextSpan(text: 'Listado de centros\n',
                            style: GoogleFonts.montserrat(
                              fontSize: 19,
                              fontWeight: FontWeight.bold,
                            ),),
                          TextSpan(text: '\n', style: GoogleFonts.montserrat(
                            fontSize: 6,
                          )
                          ),
                          TextSpan(
                            text: 'Información organizada y accesible', style: GoogleFonts.montserrat(
                            fontSize: 15,
                          )
                          ),
                        ],
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xFF6E896A),
                      minimumSize: Size(double.infinity, 110),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),


                  SizedBox(height: 10.0),


                  ElevatedButton(
                    onPressed: () async {
                      await FirebaseAuth.instance.signOut();

                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => LoginScreen(),
                        ),
                      );
                    },
                    child:  Text('Cerrar sesión',
                      style: GoogleFonts.montserrat(fontSize: 18),),
                    style:
                      ElevatedButton.styleFrom(
                        primary: Colors.black,
                        minimumSize: Size(double.infinity, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),

              ],
            ),
          ),
        )
      )
      )
    );
  }

  Future<dynamic> Logout() async {

    await FirebaseAuth.instance.signOut();

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => LoginScreen(),
      ),
    );
  }
}
