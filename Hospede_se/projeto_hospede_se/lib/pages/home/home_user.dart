import 'package:flutter/material.dart';
import 'package:projeto_hospede_se/pages/home/page_manager.dart';
import 'package:projeto_hospede_se/pages/rooms/room_manager.dart';
import 'package:projeto_hospede_se/widgets/drawer.dart';
import 'package:provider/provider.dart';

class HomeUserPage extends StatefulWidget {
  @override
  State<HomeUserPage> createState() => _HomeUserPageState();
}

class _HomeUserPageState extends State<HomeUserPage> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green.shade300,
      appBar: AppBar(
        backgroundColor: Colors.green.shade800,
      ),
      body: Column(),
    );
  }
}
