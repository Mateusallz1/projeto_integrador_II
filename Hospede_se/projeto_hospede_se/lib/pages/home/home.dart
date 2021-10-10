import 'package:flutter/material.dart';
import 'package:projeto_hospede_se/styles/style.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green.shade800,
      ),
      body: Center(
        child: Text(
          'Home',
          style: titleText,
        ),
      ),
    );
  }
}
