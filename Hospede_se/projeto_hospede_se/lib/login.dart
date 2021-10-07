import 'package:flutter/material.dart';
import 'package:projeto_hospede_se/models/user.dart';
import 'package:projeto_hospede_se/models/user_manager.dart';
import 'package:projeto_hospede_se/styles/style.dart';
import 'package:projeto_hospede_se/helpers/validators.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  final emailController = TextEditingController();
  final passController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pushNamed('/signup');
            },
            child: const Text(
              'Criar Conta',
              style: TextStyle(fontSize: 14),
            ),
          )
        ],
      ),
      body: Theme(
        data: Theme.of(context).copyWith(
          colorScheme: const ColorScheme.light(primary: Colors.green),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Form(
              key: formKey,
              child: ListView(
                padding: const EdgeInsets.all(20),
                shrinkWrap: true,
                children: [
                  Container(
                    margin: const EdgeInsets.all(5),
                    child: TextFormField(
                      controller: emailController,
                      decoration: inputDecorationRadius('Email'),
                      keyboardType: TextInputType.emailAddress,
                      autocorrect: false,
                      validator: (email) {
                        if (!emailValid(email!)) {
                          return 'E-mail inválido';
                        }
                      },
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(5),
                    child: TextFormField(
                      controller: passController,
                      decoration: inputDecorationRadius('Senha'),
                      autocorrect: false,
                      obscureText: true,
                      validator: (pass) {
                        if (pass!.isEmpty || pass.length < 6) {
                          return 'Senha inválida';
                        }
                      },
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
                                UserLogin(
                                    email: emailController.text,
                                    password: passController.text),
                              );
                        }
                      },
                      child: const Text('Login'),
                      style: elevatedButton,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
