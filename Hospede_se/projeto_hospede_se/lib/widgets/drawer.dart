import 'package:flutter/material.dart';
import 'package:projeto_hospede_se/widgets/drawer_tile.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerTile(
            icondata: Icons.home,
            title: 'Início',
          ),
          DrawerTile(
            icondata: Icons.list,
            title: 'Quartos',
          ),
          DrawerTile(
            icondata: Icons.playlist_add_check,
            title: 'Estadias',
          ),
        ],
      ),
    );
  }
}
