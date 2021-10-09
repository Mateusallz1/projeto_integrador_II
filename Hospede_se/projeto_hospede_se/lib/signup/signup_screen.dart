import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:projeto_hospede_se/styles/style.dart';
import 'package:projeto_hospede_se/helpers/validators.dart';
import 'package:projeto_hospede_se/models/user.dart';
import 'package:projeto_hospede_se/models/user_manager.dart';

class SignUpPage extends StatelessWidget {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  UserApp user = UserApp(id: '', name: '', email: '', password: '', confirmPassword: '');

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
        // FORM CADASTRO
        child: Card(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          child: Form(
            key: formKey,
            child: ListView(
              padding: const EdgeInsets.all(16),
              shrinkWrap: true,
              children: <Widget>[
                //NOME COMPLETO
                TextFormField(
                  decoration: const InputDecoration(hintText: 'Nome Completo'),
                  validator: (name) => Validators.validateName(name!),
                  onSaved: (name) => user.name = name!,
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  decoration: const InputDecoration(hintText: 'E-mail'),
                  keyboardType: TextInputType.emailAddress,
                  onSaved: (email) => user.email = email!,
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  decoration: const InputDecoration(hintText: 'Senha'),
                  obscureText: true,
                  validator: (pass) => Validators.validatePassword(pass!),
                  onSaved: (pass) => user.password = pass!,
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  decoration: const InputDecoration(hintText: 'Confirmar Senha'),
                  obscureText: true,
                  validator: (pass) => Validators.validatePassword(pass!),
                  onSaved: (pass) => user.confirmPassword = pass!,
                ),
                const SizedBox(
                  height: 30,
                ),
                ElevatedButton(
                  style: elevatedButtonConfirm,
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      formKey.currentState!.save();
                      if (!Validators.comparePassword(user.password, user.confirmPassword)) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Senhas não coincidem'),
                            backgroundColor: Colors.red,
                          ),
                        );
                      }
                      context.read<UserManager>().signUp(
                        user,
                        () {
                          Navigator.of(context).pop();
                        },
                        (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Falha no cadastro: $e'),
                              backgroundColor: Colors.red,
                            ),
                          );
                        },
                      );
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
