import 'package:flutter/material.dart';
import 'package:projeto_hospede_se/models/user.dart';
import 'package:projeto_hospede_se/models/user_manager.dart';
import 'package:projeto_hospede_se/registerhotel.dart';
import 'package:projeto_hospede_se/styles/style.dart';
import 'package:projeto_hospede_se/helpers/validators.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  final email = TextEditingController();
  final passwd = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.green.shade200,
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.green.shade800,
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pushNamed('/signup');
            },
            child: Text(
              'Registre-se',
              style: titleText2,
            ),
          )
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'Login',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    height: 2,
                    fontSize: 35,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(1),
                  child: Form(
                    key: formKey,
                    child: ListView(
                      shrinkWrap: true,
                      padding: const EdgeInsets.all(20),
                      children: [
                        Container(
                          margin: const EdgeInsets.all(20),
                          child: TextFormField(
                            controller: email,
                            decoration: inputDecorationRadius('Email'),
                            keyboardType: TextInputType.emailAddress,
                            autocorrect: false,
                            validator: (email) => Validators.validateEmail(email!),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.all(20),
                          child: TextFormField(
                            controller: passwd,
                            decoration: inputDecorationRadius('Senha'),
                            autocorrect: false,
                            obscureText: true,
                            validator: (password) => Validators.validatePassword(password!),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.all(5),
                          padding: const EdgeInsets.all(5),
                          width: MediaQuery.of(context).size.width * 0.83,
                          height: 70,
                          child: ElevatedButton(
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                context.read<UserManager>().signIn(
                                  UserLogin(email: email.text, password: passwd.text),
                                  () {
                                    Navigator.of(context).pop();
                                  },
                                  (e) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(e.message),
                                      ),
                                    );
                                  },
                                );
                              }
                            },
                            child: const Text('Login'),
                            style: elevatedButton,
                          ),
                        ),
                      ],
                    ),
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
