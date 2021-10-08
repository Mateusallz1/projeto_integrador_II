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
      //backgroundColor: Colors.green.shade200,
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.green.shade800,
        actions: <Widget>[
          TextButton(
            
            onPressed: () {
              Navigator.of(context).pushNamed('/signup');
            },
            child: const Text(
              'Registre-se',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white, 
                fontSize: 16
              ),
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
                const Text(
                  'Login',
                    style: TextStyle( //mesma configuração da tela de Welcome      
                    color: Colors.black,
                    fontWeight: FontWeight.bold, 
                    height: 2, 
                    fontSize: 35,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(1),
                  child: TextField(
                    decoration: inputDecorationRadius('Email'),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(1),
                  child: TextField(
                    decoration: inputDecorationRadius('Senha'),
                    obscureText: true,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(10),
                  child: ElevatedButton.icon(
                    onPressed: () { // tem que ter um if
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
