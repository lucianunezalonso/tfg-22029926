import 'package:app_tfg/screens/opcion1_test.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../screens/login_screen.dart';

import '../screens/opcion1_test.dart';
import '../screens/opcion2_test.dart';
import '../screens/opcion3_listado.dart';
import '../screens/opcion4_listado.dart';

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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('AdoptionMovement'),
        centerTitle: true,
      ),

      body: WillPopScope(
        onWillPop: () async {
          final logout = await showDialog<bool>(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: new Text('Estás seguro?'),
                content: new Text('Quieres cerrar sesión en la app'),
                actionsAlignment: MainAxisAlignment.spaceBetween,
                actions: [
                  TextButton(
                    onPressed: () {
                      Logout();
                    },
                    child: const Text('Sí'),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context, false);
                    },
                    child: const Text('No'),
                  ),
                ],
              );
            },
          );
          return logout!;
        },


        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Center(
              child: Column(



                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '¡Hola ${_currentUser.displayName}!',
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 22.0),
                  ),
                  SizedBox(height: 10.0),
                  Text('¿Qué quieres hacer hoy?',
                    style: TextStyle(fontSize: 17.0),),
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
                      text: const TextSpan(
                        style: TextStyle(fontSize: 20),
                        children: [
                          TextSpan(text: '¿Necesitas que un animal sea adoptado?\n'),
                          TextSpan(text: 'Te recomendamos a donde llevarlo', style: TextStyle(fontStyle: FontStyle.italic, fontWeight: FontWeight.bold, fontSize: 18)),
                        ],
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary:  Color(0xFFEE892F),
                      minimumSize: Size(double.infinity, 120),
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
                          TextSpan(text: 'Haz el test de compatibilidad\n'),
                          TextSpan(text: 'Con los resultados sabremos qué animales se adaptan a ti', style: TextStyle(fontStyle: FontStyle.italic, fontWeight: FontWeight.bold, fontSize: 18)),
                        ],
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary:  Color(0xFFE0BB76),
                      minimumSize: Size(double.infinity, 120),
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
                                    style: TextStyle(fontSize: 16),
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
                          TextSpan(text: 'Listado de centros\n'),
                          TextSpan(
                            text: 'Información organizada y disponible',
                            style: TextStyle(fontStyle: FontStyle.italic, fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                        ],
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xFF6E896A),
                      minimumSize: Size(double.infinity, 130),
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
                    child: const Text('Cerrar sesión'),
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
