import 'package:flutter/material.dart';
import 'package:projeto_hospede_se/pages/home/page_manager.dart';
import 'package:projeto_hospede_se/pages/rooms/room_manager.dart';
import 'package:projeto_hospede_se/widgets/drawer.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  //const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PageController pageController = PageController();
  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) => PageManager(pageController),
      child: PageView(
        controller: pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          Scaffold(
            backgroundColor: Colors.green.shade300,
            drawer: const CustomDrawer(),
            appBar: AppBar(
              backgroundColor: Colors.green.shade800,
              title: const Text('Início'),
            ),
          ),
          Scaffold(
            backgroundColor: Colors.green.shade300,
            drawer: const CustomDrawer(),
            appBar: AppBar(
              backgroundColor: Colors.green.shade800,
              title: const Text('Quartos'),
            ),
          ),
          Scaffold(
            backgroundColor: Colors.green.shade300,
            drawer: const CustomDrawer(),
            appBar: AppBar(
              backgroundColor: Colors.green.shade800,
              title: const Text('Estadias'),
            ),
          ),
        ],
      ),
    );
  }
}
