import 'package:flutter/material.dart';
import 'package:projeto_hospede_se/pages/home/home.dart';
import 'package:projeto_hospede_se/services/auth_service.dart';
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
      //MaterialPageRoute(builder: (context) => const HomePage());
      Navigator.pop(context);
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
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.green.shade800,
        title: const Text('Criar Conta'),
        centerTitle: true,
        elevation: 5,
      ),
      body: Center(
        child: Card(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          child: Form(
            key: formKey,
            child: ListView(
              padding: const EdgeInsets.all(16),
              shrinkWrap: true,
              children: <Widget>[
                TextFormField(
                  controller: name,
                  decoration: const InputDecoration(hintText: 'Nome Completo'),
                  validator: (name) => Validators.validateName(name!),
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  controller: email,
                  decoration: const InputDecoration(hintText: 'E-mail'),
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  controller: passwd,
                  decoration: const InputDecoration(hintText: 'Senha'),
                  obscureText: true,
                  validator: (passwd) => Validators.validatePassword(passwd!),
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  controller: cpasswd,
                  decoration: const InputDecoration(hintText: 'Confirmar Senha'),
                  obscureText: true,
                  validator: (passwd) => Validators.validatePassword(passwd!),
                ),
                const SizedBox(
                  height: 30,
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
