import 'package:flutter/material.dart';
import 'package:projeto_hospede_se/services/auth_service.dart';
import 'package:projeto_hospede_se/widgets/auth_check.dart';
import 'package:provider/provider.dart';
import 'package:projeto_hospede_se/styles/style.dart';
import 'package:projeto_hospede_se/helpers/validators.dart';
import 'package:projeto_hospede_se/models/user.dart';

class SignUpUserPage extends StatefulWidget {
  const SignUpUserPage({Key? key}) : super(key: key);

  @override
  _SignUpUserPageState createState() => _SignUpUserPageState();
}

class _SignUpUserPageState extends State<SignUpUserPage> {
  final name = TextEditingController();
  final email = TextEditingController();
  final passwd = TextEditingController();
  final cpasswd = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  void signUp() async {
    try {
      await context.read<AuthService>().signUp(UserApp(host: false, name: name.text, email: email.text, password: passwd.text, confirmPassword: cpasswd.text));
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
      backgroundColor: Colors.white,
      key: scaffoldKey,
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text("Criar Conta", style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.green.shade800,
                  ),
                ),
          
                Text("crie sua conta", style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.green.shade600,
                  ),
                ),
          
                const SizedBox(height: 20,),
                Form(
                  key: formKey,
                  child: Container(
                    height: 400,
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
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
                          validator: (email) => Validators.validateEmail(email!),
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
                          validator: (cpasswd) => Validators.comparePassword(passwd.text, cpasswd!),
                        ),
                        ElevatedButton(
                          style: elevatedButtonConfirm,
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              formKey.currentState!.save();
                              signUp();
                            }
                          },
                          child: const Text('criar conta', 
                          style: TextStyle(fontSize: 15)),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
