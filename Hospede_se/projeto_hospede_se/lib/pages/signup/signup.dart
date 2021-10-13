import 'package:flutter/material.dart';
import 'package:projeto_hospede_se/pages/home/home.dart';
import 'package:projeto_hospede_se/services/auth_service.dart';
import 'package:projeto_hospede_se/widgets/auth_check.dart';
import 'package:provider/provider.dart';
import 'package:projeto_hospede_se/styles/style.dart';
import 'package:projeto_hospede_se/helpers/validators.dart';
import 'package:projeto_hospede_se/models/user.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final name = TextEditingController();
  final email = TextEditingController();
  final passwd = TextEditingController();
  final cpasswd = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  void signUp() async {
    try {
      await context.read<AuthService>().signUp(UserApp(name: name.text, email: email.text, password: passwd.text, confirmPassword: cpasswd.text));
      //MaterialPageRoute(builder: (context) => const AuthCheck());
      Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AuthCheck()),
              );
    } on AuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(e.message),
        backgroundColor: Colors.red,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green.shade300,
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.green.shade800,
        title: const Text('Criar Conta'),
        centerTitle: true,
        elevation: 5,
      ),
      body: Center(
        child: Card(
          elevation: 10,
          margin: const EdgeInsets.symmetric(horizontal: 16),
          child: Form(
            key: formKey,
            child: ListView(
              padding: const EdgeInsets.all(16),
              shrinkWrap: true,
              children: [
                TextFormField(
                controller: name,
                decoration: inputDecorationRadius('Nome Completo'),
                validator: (name) => Validators.validateName(name!),
                ),
                TextFormField(
                  controller: email,
                  decoration: inputDecorationRadius('Email'),
                  keyboardType: TextInputType.emailAddress,
                  validator: (email) => Validators.validateName(email!),
                ),
                TextFormField(
                  controller: passwd,
                  decoration: inputDecorationRadius('Senha'),
                  obscureText: true,
                  validator: (passwd) => Validators.validatePassword(passwd!),
                ),
                TextFormField(
                  controller: cpasswd,
                  decoration: inputDecorationRadius('Confirme sua Senha'),
                  obscureText: true,
                  validator: (passwd) => Validators.validatePassword(passwd!),
                ),
                ElevatedButton(
                      style: elevatedButtonConfirm,
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          formKey.currentState!.save();
                          if (!Validators.comparePassword(passwd.text, cpasswd.text)) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Senhas não coincidem'),
                                backgroundColor: Colors.red,
                              ),
                            );
                          }
                          signUp();
                        }
                      },
                      child: const Text('Criar Conta'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
