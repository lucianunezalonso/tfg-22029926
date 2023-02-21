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
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text('Adoption Movement'),
          centerTitle: true,
        ),

        body: FutureBuilder(
          builder: (context, snapshot) {
              return Padding(
                padding: const EdgeInsets.only(
                    left: 24.0, right: 24.0, top: 48),

                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Image.asset('assets/codeigniter.png'),

                    ElevatedButton(
                      child: Text("Registrarse"),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.black),
                      ),

                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) =>
                                SignUpScreen(),
                          ),
                        );
                      },
                    ),
                    ElevatedButton(
                      child: Text("Iniciar sesión"),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.black),
                      ),

                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) =>
                                LoginScreen(),
                          ),
                        );
                      },
                    ),

                  ],
                ),
              );

          },
        ),
      ),

    );
  }
}
