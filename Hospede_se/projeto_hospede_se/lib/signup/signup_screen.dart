import 'package:flutter/material.dart';

class SignUpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Criar Conta'),
        centerTitle: true,
        elevation: 0,
      ),
      body: Center(
        child: Card(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          child: ListView(
            padding: EdgeInsets.all(16),
            shrinkWrap: true,
            children: <Widget>[
              TextFormField(
                decoration: const InputDecoration(hintText: 'Nome Completo'),
              ),
              const SizedBox(
                height: 16,
              ),
              TextFormField(
                decoration: const InputDecoration(hintText: 'E-mail'),
              ),
              const SizedBox(
                height: 16,
              ),
              TextFormField(
                decoration: const InputDecoration(hintText: 'Senha'),
              ),
              const SizedBox(
                height: 16,
              ),
              TextFormField(
                decoration: const InputDecoration(hintText: 'Confirmar Senha'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
