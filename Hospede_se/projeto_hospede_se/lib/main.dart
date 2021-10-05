import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:projeto_hospede_se/login.dart';
import 'package:projeto_hospede_se/signup/signup_screen.dart';
import 'package:projeto_hospede_se/welcome.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/welcome',
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/login':
            return MaterialPageRoute(builder: (_) => const LoginPage());
          case '/signup':
            return MaterialPageRoute(builder: (_) => SignUpPage());
          default:
            return MaterialPageRoute(builder: (_) => const WelcomeScreen());
        }
      },
    );
    //home: LoginPage());
  }
}
