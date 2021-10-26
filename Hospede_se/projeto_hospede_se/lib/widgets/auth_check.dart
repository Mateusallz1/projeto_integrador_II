import 'package:flutter/material.dart';
import 'package:projeto_hospede_se/pages/home/user/home_user.dart';
import 'package:projeto_hospede_se/pages/home/host/home_host.dart';
import 'package:projeto_hospede_se/pages/welcome/welcome.dart';
import 'package:projeto_hospede_se/services/auth_service.dart';
import 'package:provider/provider.dart';

class AuthCheck extends StatefulWidget {
  const AuthCheck({Key? key}) : super(key: key);

  @override
  _AuthCheckState createState() => _AuthCheckState();
}

class _AuthCheckState extends State<AuthCheck> {
  @override
  Widget build(BuildContext context) {
    AuthService auth = Provider.of<AuthService>(context);

    if (auth.isLoading) {
      return loading();
    } else if (!auth.isLogged()) {
      return const WelcomePage();
    } else {
      return auth.getUser().host == true ? const HomeHostPage() : const HomeUserPage();
    }
  }

  loading() {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
