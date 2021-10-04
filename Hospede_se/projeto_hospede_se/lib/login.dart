import 'package:flutter/material.dart';
import 'package:projeto_hospede_se/styles/style.dart';
import 'package:projeto_hospede_se/registerhotel.dart';

class LoginPage extends StatefulWidget {
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
          FlatButton(
            onPressed: () {
              Navigator.of(context).pushNamed('/signup');
            },
            textColor: Colors.white,
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
            margin: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Hospede-se',
                  style: titleText,
                ),
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Email',
                    labelStyle: TextStyle(
                      color: Colors.green,
                    ),
                    icon: Icon(
                      Icons.email,
                      color: Colors.green,
                    ),
                    enabledBorder: inputBorderGreen,
                    focusedBorder: inputFocusedBorderGreen,
                  ),
                ),
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Senha',
                    labelStyle: TextStyle(
                      color: Colors.green,
                    ),
                    icon: Icon(
                      Icons.password,
                      color: Colors.green,
                    ),
                    enabledBorder: inputBorderGreen,
                    focusedBorder: inputFocusedBorderGreen,
                  ),
                  obscureText: true,
                ),
                Container(
                  margin: EdgeInsets.all(10),
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => RegisterHotel()),
                      );
                    },
                    icon: Icon(Icons.login),
                    label: Text('Login'),
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
