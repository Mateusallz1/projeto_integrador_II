import 'package:flutter/material.dart';

class ExploreUserPage extends StatefulWidget {
  const ExploreUserPage({Key? key}) : super(key: key);

  @override
  State<ExploreUserPage> createState() => _ExploreUserPage();
}

class _ExploreUserPage extends State<ExploreUserPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green.shade100,
      appBar: AppBar(
        backgroundColor: Colors.green.shade800,
        title: const Text('Explorar'),
      ),
    );
  }
}
