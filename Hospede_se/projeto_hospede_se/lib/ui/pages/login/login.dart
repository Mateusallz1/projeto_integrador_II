import 'package:flutter/material.dart';
import 'package:projeto_hospede_se/models/user.dart';
import 'package:projeto_hospede_se/services/auth_service.dart';
import 'package:projeto_hospede_se/ui/styles/style.dart';
import 'package:projeto_hospede_se/helpers/validators.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  late TextEditingController _email;
  get email => _email.text;

  late TextEditingController _passwd;
  get passwd => _passwd.text;

  late FocusNode fnemail;
  late FocusNode fnpasswd;
  late FocusNode fnsubmit;

  bool _loading = false;

  @override
  void initState() {
    super.initState();
    _email = TextEditingController();
    _passwd = TextEditingController();
    fnemail = FocusNode();
    fnpasswd = FocusNode();
    fnsubmit = FocusNode();
  }

  void signIn() async {
    setState(() => _loading = true);
    try {
      await context.read<AuthService>().signIn(UserLogin(email: email, password: passwd));
      Navigator.pop(context);
    } on AuthException catch (e) {
      setState(() => _loading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.message),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.all(30),
                  child: Text(
                    'Bem-Vindo de Volta!',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.green.shade800,
                    ),
                  ),
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        autofocus: true,
                        focusNode: fnemail,
                        controller: _email,
                        decoration: inputDecorationRadius('Email'),
                        keyboardType: TextInputType.emailAddress,
                        autocorrect: false,
                        validator: (email) => Validators.validateEmail(email!),
                        onFieldSubmitted: (email) {
                          fnemail.unfocus();
                          FocusScope.of(context).requestFocus(fnpasswd);
                        },
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 10),
                        child: TextFormField(
                          focusNode: fnpasswd,
                          controller: _passwd,
                          decoration: inputDecorationRadius('Senha'),
                          autocorrect: false,
                          obscureText: true,
                          validator: (password) => Validators.validatePassword(password!),
                          onFieldSubmitted: (passwd) {
                            fnpasswd.unfocus();
                            FocusScope.of(context).requestFocus(fnsubmit);
                          },
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            child: const Text(
                              'Esqueceu sua senha?',
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                                color: Colors.green,
                              ),
                            ),
                            onPressed: () {},
                          ),
                        ],
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.075,
                        child: ElevatedButton(
                          focusNode: fnsubmit,
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              signIn();
                            }
                          },
                          style: elevatedButtonConfirm,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: (_loading)
                                ? [
                                    const SizedBox(
                                      width: 24,
                                      height: 24,
                                      child: CircularProgressIndicator(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ]
                                : [
                                    const Text(
                                      'Entrar',
                                    ),
                                  ],
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            margin: const EdgeInsets.all(10),
                            child: const Text(
                              'Não possui conta? ',
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            ),
                          ),
                          GestureDetector(
                            child: const Text(
                              'Registre-se',
                              style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontSize: 20),
                            ),
                            onTap: () {},
                          ),
                        ],
                      )
                    ],
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
