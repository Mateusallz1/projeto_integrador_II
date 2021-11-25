import 'package:flutter/cupertino.dart';
import 'package:projeto_hospede_se/ui/pages/login/login.dart';
import 'package:projeto_hospede_se/ui/pages/signup/signup.dart';
import 'package:projeto_hospede_se/styles/style.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Bem-Vindo!',
                  style: GoogleFonts.ubuntu(
                    textStyle: const TextStyle(
                      fontWeight: FontWeight.w900,
                      height: 2,
                      fontSize: 35,
                    ),
                  ),
                ),
                Text(
                  'Este é um aplicativo de hospedagens\n\n',
                  style: GoogleFonts.roboto(
                    textStyle: const TextStyle(fontSize: 18.5, color: Colors.grey),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    ElevatedButton.icon(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginPage()));
                        },
                        icon: const Icon(Icons.login),
                        label: const Text('Login'),
                        style: elevatedButton),
                    ElevatedButton.icon(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const SignUpPage()));
                      },
                      icon: const Icon(Icons.app_registration),
                      label: const Text('Registre-se'),
                      style: elevatedButton,
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
