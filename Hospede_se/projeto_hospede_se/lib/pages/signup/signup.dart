import 'package:flutter/material.dart';
import 'package:projeto_hospede_se/pages/signup/signup_host.dart';
import 'package:projeto_hospede_se/pages/signup/signup_user.dart';
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
      key: scaffoldKey,
      body: Container(
        margin: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Você deseja procurar por hotéis ou possuir um hotel?',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                //height: 2,
                fontSize: 25,
              ),
            ),
            Text(
              'Selecione o tipo de conta que atende seus objetivos.',
              style: descTextGrey,
              textAlign: TextAlign.center,
            ),
            ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const SignUpUserPage()),
                  );
                },
                icon: const Icon(Icons.person),
                label: const Text('Hóspede'),
                style: elevatedButton),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SignUpHostPage()),
                );
              },
              icon: const Icon(Icons.business),
              label: const Text('Anfitrião'),
              style: elevatedButton,
            ),
          ],
        ),
      ),
    );
  }
}
