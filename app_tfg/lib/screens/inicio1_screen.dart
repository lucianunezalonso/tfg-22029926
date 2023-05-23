import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import '../screens/login_screen.dart';
import '../screens/home_screen.dart';
import '../screens/signup_screen.dart';
import 'package:google_fonts/google_fonts.dart';


import '../helper/firebase_auth.dart';
import '../helper/validator.dart';

class Inicio1Screen extends StatefulWidget {
  @override
  _Inicio1ScreenState createState() => _Inicio1ScreenState();
}

class _Inicio1ScreenState extends State<Inicio1Screen> {
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
      home: GestureDetector(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.black,
            title: Text('AdoptionMovement',
              style: GoogleFonts.montserrat(),),
            centerTitle: true,
          ),
          body: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/perro_inicio.jpeg'),
                fit: BoxFit.cover,
              ),
            ),
            child:  Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: kToolbarHeight), // Añade un espacio del tamaño del AppBar
                SizedBox(height: 22),
                Image.asset('assets/images/logo.png'),
                SizedBox(height: 370),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      child: Text(
                        "Registrarse",
                        style: GoogleFonts.montserrat(fontSize: 18),
                      ),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.black),
                        padding: MaterialStateProperty.all(EdgeInsets.symmetric(horizontal: 24, vertical: 5)), // Aumenta el relleno del botón
                      ),
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => SignUpScreen(),
                          ),
                        );
                      },
                    ),
                    SizedBox(width: 16), // Espacio entre los botones
                    ElevatedButton(
                      child: Text(
                        "Iniciar sesión",
                        style: GoogleFonts.montserrat(fontSize: 18),                      ),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.black),
                        padding: MaterialStateProperty.all(EdgeInsets.symmetric(horizontal: 24, vertical: 5)), // Aumenta el relleno del botón
                      ),
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => LoginScreen(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        ),
      ),
    );
  }
}
