import 'package:flutter/material.dart';
import 'package:projeto_hospede_se/models/user.dart';
import 'package:projeto_hospede_se/pages/home/home.dart';
import 'package:projeto_hospede_se/pages/signup/signup.dart';
import 'package:projeto_hospede_se/services/auth_service.dart';
import 'package:projeto_hospede_se/styles/style.dart';
import 'package:projeto_hospede_se/helpers/validators.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final email = TextEditingController();
  final passwd = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  void SignIn() async {
    try {
      await context.read<AuthService>().signIn(UserLogin(email: email.text, password: passwd.text));
      Navigator.pop(context);
      //MaterialPageRoute(builder: (context) => const HomePage());
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
      appBar: AppBar(
        backgroundColor: Colors.green.shade800,
        actions: [
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SignUpPage()),
              );
            },
            child: Text(
              'Registre-se',
              style: labelTextWhite,
            ),
          )
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Login',
            style: titleText2Black,
          ),
          Container(
            margin: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Form(
                  key: formKey,
                  child: ListView(
                    shrinkWrap: true,
                    padding: const EdgeInsets.all(20),
                    children: [
                      Container(
                        margin: const EdgeInsets.only(bottom: 10),
                        child: TextFormField(
                          controller: email,
                          decoration: inputDecorationRadius('Email'),
                          keyboardType: TextInputType.emailAddress,
                          autocorrect: false,
                          validator: (email) => Validators.validateEmail(email!),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(bottom: 10),
                        child: TextFormField(
                          controller: passwd,
                          decoration: inputDecorationRadius('Senha'),
                          autocorrect: false,
                          obscureText: true,
                          validator: (password) => Validators.validatePassword(password!),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.83,
                        height: 70,
                        child: ElevatedButton(
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              SignIn();
                            }
                          },
                          child: const Text('Login'),
                          style: elevatedButton,
                        ),
                      ),
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
