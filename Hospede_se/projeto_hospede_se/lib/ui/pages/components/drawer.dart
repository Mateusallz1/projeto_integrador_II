import 'package:flutter/material.dart';
import 'package:projeto_hospede_se/ui/pages/components/drawer_tile.dart';
import 'package:projeto_hospede_se/ui/pages/components/header_drawer.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: const [
          CustomDrawerHeader(),
          DrawerTile(
            icondata: Icons.home,
            title: 'Início',
            page: 0,
          ),
          DrawerTile(
            icondata: Icons.list,
            title: 'Quartos',
            page: 1,
          ),
          DrawerTile(
            icondata: Icons.playlist_add_check,
            title: 'Estadias',
            page: 2,
          ),
        ],
      ),
    );
  }
}
