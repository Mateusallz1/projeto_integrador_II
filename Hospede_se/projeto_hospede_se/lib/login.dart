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
<<<<<<< HEAD
      //backgroundColor: Colors.green.shade200,
      key: scaffoldKey,
=======
>>>>>>> 79cba8860fb84e81d60a4ff57801a369b4a3cd6a
      appBar: AppBar(
        backgroundColor: Colors.green.shade800,
        actions: <Widget>[
          TextButton(
            
            onPressed: () {
              Navigator.of(context).pushNamed('/signup');
            },
            child: const Text(
<<<<<<< HEAD
              'Registre-se',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white, 
                fontSize: 16
              ),
=======
              'Criar Conta',
              style: TextStyle(fontSize: 14),
>>>>>>> 79cba8860fb84e81d60a4ff57801a369b4a3cd6a
            ),
          )
        ],
      ),
<<<<<<< HEAD
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
=======
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
>>>>>>> 79cba8860fb84e81d60a4ff57801a369b4a3cd6a
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
