import 'package:flutter/material.dart';
import 'package:projeto_hospede_se/styles/style.dart';
import 'package:projeto_hospede_se/registerhotel.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        actions: <Widget>[
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pushNamed('/signup');
            },
            child: const Text(
              'CRIAR CONTA',
              style: TextStyle(fontSize: 14),
            ),
          )
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Hospede-se',
                  style: titleText,
                ),
                Container(
                  margin: const EdgeInsets.all(5),
                  child: TextField(
                    decoration: inputDecorationRadius('Email'),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(5),
                  child: TextField(
                    decoration: inputDecorationRadius('Senha'),
                    obscureText: true,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(10),
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const RegisterHotel()),
                      );
                    },
                    icon: const Icon(Icons.login),
                    label: const Text('Login'),
                    style: elevatedButton,
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
