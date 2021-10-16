import 'package:flutter/material.dart';
import 'package:projeto_hospede_se/widgets/drawer.dart';

class HomePage extends StatelessWidget {
  //const HomePage({Key? key}) : super(key: key);

  final PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: pageController,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        Scaffold(
          backgroundColor: Colors.green.shade300,
          drawer: const CustomDrawer(),
          appBar: AppBar(
            title: const Text('Home'),
          ),
        ),
        Container(
          color: Colors.green,
        ),
        Container(
          color: Colors.yellow,
        ),
        Container(
          color: Colors.blue,
        )
      ],
    );
  }
}
