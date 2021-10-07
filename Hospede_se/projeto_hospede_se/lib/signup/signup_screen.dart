import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:projeto_hospede_se/helpers/validators.dart';
import 'package:projeto_hospede_se/models/user.dart';
import 'package:projeto_hospede_se/models/user_manager.dart';
import 'package:provider/provider.dart';

class SignUpPage extends StatelessWidget {
  final ButtonStyle style = ElevatedButton.styleFrom(
      primary: Colors.green,
      padding: const EdgeInsets.symmetric(vertical: 12),
      textStyle: const TextStyle(
        fontSize: 20,
      ));

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  UserApp user =
      UserApp(id: '', name: '', email: '', password: '', confirmPassword: '');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: const Text('Criar Conta'),
        centerTitle: true,
        elevation: 0,
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
                  decoration: const InputDecoration(hintText: 'Nome Completo'),
                  validator: (name) {
                    if (name!.isEmpty) {
                      return 'Campo obrigatório';
                    } else if (name.trim().split(' ').length <= 1) {
                      return 'Preencha seu nome completo';
                    }
                    return null;
                  },
                  onSaved: (name) => user.name = name!,
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  decoration: const InputDecoration(hintText: 'E-mail'),
                  keyboardType: TextInputType.emailAddress,
                  validator: (email) {
                    if (email!.isEmpty) {
                      return 'Campo obrigatório';
                    } else if (!emailValid(email)) {
                      return 'E-mail inválido';
                    }
                    return null;
                  },
                  onSaved: (email) => user.email = email!,
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  decoration: const InputDecoration(hintText: 'Senha'),
                  obscureText: true,
                  validator: (pass) {
                    if (pass!.isEmpty) {
                      return 'Campo obrigatório';
                    } else if (pass.length < 8) {
                      return 'Senha muito curta. Mínimo 8 caracteres';
                    }
                    return null;
                  },
                  onSaved: (pass) => user.password = pass!,
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  decoration:
                      const InputDecoration(hintText: 'Confirmar Senha'),
                  obscureText: true,
                  validator: (pass) {
                    if (pass!.isEmpty) {
                      return 'Campo obrigatório';
                    } else if (pass.length < 8) {
                      return 'Senha muito curta. Mínimo 8 caracteres';
                    }
                    return null;
                  },
                  onSaved: (pass) => user.confirmPassword = pass!,
                ),
                const SizedBox(
                  height: 30,
                ),
                ElevatedButton(
                  style: style,
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      formKey.currentState!.save();
                      if (user.password != user.confirmPassword) {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text('Senhas não coincidem'),
                          backgroundColor: Colors.red,
                        ));
                        return;
                      }
                      context.read<UserManager>().signUp(user, () {
                        // TODO: POP
                      }, (e) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text('Falha no cadastro: $e'),
                          backgroundColor: Colors.red,
                        ));
                      });
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
