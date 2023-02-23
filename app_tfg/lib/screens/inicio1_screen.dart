import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import '../screens/login_screen.dart';
import '../screens/home_screen.dart';
import '../screens/signup_screen.dart';


import '../helper/firebase_auth.dart';
import '../helper/validator.dart';

class Inicio1Screen extends StatefulWidget {
  @override
  _Inicio1ScreenState createState() => _Inicio1ScreenState();
}

class _Inicio1ScreenState extends State<Inicio1Screen> {

  @override
  Widget build(BuildContext context) {
    return GestureDetector(


      child: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/perro_inicio.jpeg'),
            fit: BoxFit.cover,
          ),
        ),



        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.black,
            title: Text('Adoption Movement'),
            centerTitle: true,
          ),

        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              child: Text("Registrarse"),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.black),
              ),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => SignUpScreen(),
                  ),
                );
              },
            ),
            SizedBox(width: 16),
            ElevatedButton(
              child: Text("Iniciar sesión"),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.black),
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
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,


      ),
      )
    );
  }
}


