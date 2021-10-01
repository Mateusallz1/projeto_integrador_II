import 'package:projeto_hospede_se/login.dart';
import 'package:projeto_hospede_se/styles/style.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.all(20),
            child: Column(
              children: [
                Text(
                  'Bem Vindo',
                  style: titleText,
                ),
                Text(
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
                  style: descText,
                  textAlign: TextAlign.center,
                ),
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      ElevatedButton.icon(
                          onPressed: () {},
                          icon: Icon(Icons.person),
                          label: Text('Hóspede'),
                          style: elevatedButton),
                      ElevatedButton.icon(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginPage()),
                            );
                          },
                          icon: Icon(Icons.business),
                          label: Text('Anfitrião'),
                          style: elevatedButton),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
