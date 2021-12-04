import 'package:flutter/material.dart';
import 'package:projeto_hospede_se/services/auth_service.dart';
import 'package:projeto_hospede_se/services/hotel_service.dart';
import 'package:projeto_hospede_se/ui/styles/style.dart';
import 'package:projeto_hospede_se/widgets/auth_check.dart';
import 'package:provider/provider.dart';

class ProfileUserPage extends StatefulWidget {
  const ProfileUserPage({Key? key}) : super(key: key);

  @override
  State<ProfileUserPage> createState() => _ProfileUserPage();
}

class _ProfileUserPage extends State<ProfileUserPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer2<AuthService, HotelsProvider>(
        builder: (_, auth, hotels, __) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('Deseja Sair?'),
                        content: const Text('Tem certeza?'),
                        actions: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ElevatedButton(
                                style: elevatedButton,
                                onPressed: () {
                                  if (auth.isLogged()) {
                                    auth.signOut();
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => const AuthCheck()),
                                    );
                                  } else {
                                    MaterialPageRoute(builder: (context) => const AuthCheck());
                                  } 
                                }, 
                                child: const Text('Sim'),
                              ),
                              ElevatedButton(
                                style: elevatedButton,
                                onPressed: () {
                                  Navigator.pop(context);
                                }, 
                                child: const Text('Não')),
                            ],
                          )
                        ],
                      )
                    );
                  },
                  child: const Text('Sair'),
                  style: elevatedButton,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}