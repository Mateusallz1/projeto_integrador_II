import 'package:projeto_hospede_se/pages/login/login.dart';
import 'package:projeto_hospede_se/styles/style.dart';
import 'package:flutter/material.dart';

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
              children: [
                const Text(
                  'Bem-Vindo!',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    height: 2,
                    fontSize: 35,
                  ),
                ),
                Text(
                  'Você está em um aplicativo de hospedagem de Hotel!',
                  style: descTextGrey,
                  textAlign: TextAlign.center,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    ElevatedButton.icon(onPressed: () {}, icon: const Icon(Icons.person), label: const Text('Hóspede'), style: elevatedButton),
                    ElevatedButton.icon(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const LoginPage()),
                        );
                      },
                      icon: const Icon(Icons.business),
                      label: const Text('Anfitrião'),
                      style: elevatedButton,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
