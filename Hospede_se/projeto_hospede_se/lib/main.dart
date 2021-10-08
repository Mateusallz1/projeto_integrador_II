import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:projeto_hospede_se/login.dart';
import 'package:projeto_hospede_se/signup/signup_screen.dart';
import 'package:projeto_hospede_se/welcome.dart';
import 'package:projeto_hospede_se/models/user_manager.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => UserManager(),
      child: MaterialApp(
        initialRoute: '/welcome',
        onGenerateRoute: (settings) {
          switch (settings.name) {
            case '/login':
              return MaterialPageRoute(builder: (_) => LoginPage());
            case '/signup':
              return MaterialPageRoute(builder: (_) => SignUpPage());
            default:
              return MaterialPageRoute(builder: (_) => const WelcomeScreen());
          }
        },
      ),
    );
  }
}
