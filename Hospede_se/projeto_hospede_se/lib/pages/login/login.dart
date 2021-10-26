import 'package:flutter/material.dart';
import 'package:projeto_hospede_se/models/user.dart';

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

  void signIn() async {
    try {
      await context.read<AuthService>().signIn(UserLogin(email: email.text, password: passwd.text));
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
      backgroundColor: Colors.white,  
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 40,),
                Icon(Icons.person_outlined, color: Colors.green.shade800, size: 140,),
                const SizedBox(height: 13,),
          
                Text("Bem-Vindo de Volta!", style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.green.shade800,
                  ),
                ),
          
                Text("Adentres ou morra", style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.green.shade600,
                  ),
                ),
          
                const SizedBox(height: 20,),

                Form(
                  key: formKey,
                  child: Column(
                    //shrinkWrap: true,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        child: TextFormField(
                          controller: email,
                          decoration: inputDecorationRadius('Email'),
                          keyboardType: TextInputType.emailAddress,
                          autocorrect: false,
                          validator: (email) => Validators.validateEmail(email!),
                        ),
                      ),
          
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        child: TextFormField(
                          controller: passwd,
                          decoration: inputDecorationRadius('Senha'),
                          autocorrect: false,
                          obscureText: true,
                          validator: (password) => Validators.validatePassword(password!),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                        TextButton(
                          onPressed: () {
                
                          }, 
                          child: const Text(
                            "Esqueceu sua senha?", 
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight:  FontWeight.bold,
                              color: Colors.green,
                              ),
                            )
                          )
                        ],
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.83,
                        height: 70,
                        child: ElevatedButton(
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              signIn();
                            }
                          },
                          child: const Text('Login'),
                          style: elevatedButtonConfirm),
                        ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Não possui conta? ",
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                          
                          GestureDetector(
                            onTap: () {
                              
                            },
                            child: const Text(
                              "Registre-se",
                              style: TextStyle(
                                color: Colors.green,
                                fontWeight: FontWeight.bold,
                                fontSize: 20
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  )
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
