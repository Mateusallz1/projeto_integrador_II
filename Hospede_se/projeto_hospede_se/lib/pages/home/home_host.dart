import 'package:flutter/material.dart';
import 'package:projeto_hospede_se/pages/home/page_manager.dart';
import 'package:projeto_hospede_se/pages/rooms/room_manager.dart';
import 'package:projeto_hospede_se/widgets/drawer.dart';
import 'package:projeto_hospede_se/widgets/room_list_tile.dart';
import 'package:provider/provider.dart';
import 'package:fluttertoast/fluttertoast.dart';

class HomeHostPage extends StatefulWidget {
  @override
  State<HomeHostPage> createState() => _HomeHostPageState();
}

class _HomeHostPageState extends State<HomeHostPage> {
  final GlobalKey<ScaffoldState> scaffoldKeyRooms = GlobalKey<ScaffoldState>();

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
            backgroundColor: Colors.green.shade100,
            drawer: const CustomDrawer(),
            appBar: AppBar(
              backgroundColor: Colors.green.shade800,
              title: const Text('Início'),
            ),
          ),
          Scaffold(
            key: scaffoldKeyRooms,
            backgroundColor: Colors.green.shade100,
            drawer: const CustomDrawer(),
            appBar: AppBar(
              backgroundColor: Colors.green.shade800,
              title: const Text('Quartos'),
            ),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.75,
                  child: Expanded(
                    child: Card(
                        margin: const EdgeInsets.all(10),
                        elevation: 10,
                        color: Colors.white,
                        child: Row(
                          children: [
                            Expanded(
                              child: Consumer<RoomManager>(
                                builder: (_, roomManager, __) { 
                                  return ListView.builder(
                                    itemCount: roomManager.allRooms.length,
                                    itemBuilder: (_, index) {
                                      return RoomListTile(roomManager.allRooms[index]);
                                    },
                                  ); 
                               },
                              )
                            )
                          ],
                        )
                      ),
                  ),
                ),
              ],
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () => Fluttertoast.showToast(msg: 'Redirecionar para tela de registrar quarto'),
              child: const Icon(Icons.add),
              backgroundColor: Colors.green.shade800,
            ),
          ),
          Scaffold(
            backgroundColor: Colors.green.shade100,
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
