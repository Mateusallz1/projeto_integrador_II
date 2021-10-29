import 'package:flutter/material.dart';
import 'package:projeto_hospede_se/models/hotel_manager.dart';
import 'package:projeto_hospede_se/models/room_manager.dart';
import 'package:projeto_hospede_se/pages/rooms/registration_room.dart';
import 'package:projeto_hospede_se/services/auth_service.dart';
import 'package:projeto_hospede_se/pages/components/drawer.dart';
import 'package:projeto_hospede_se/pages/components/room_list_tile.dart';
import 'package:provider/provider.dart';

class RoomsPage extends StatefulWidget {
  const RoomsPage({Key? key}) : super(key: key);

  @override
  State<RoomsPage> createState() => _RoomsPageState();
}

class _RoomsPageState extends State<RoomsPage> {
  final GlobalKey<ScaffoldState> scaffoldKeyRooms = GlobalKey<ScaffoldState>();
  final PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    AuthService authService = context.read<AuthService>();
    HotelManager hotelManager = context.read<HotelManager>();
    RoomManager roomManager = context.read<RoomManager>();
    hotelManager.loadHotel(authService.getUser().id.toString());
    roomManager.loadRooms(hotelManager.getHotel().id);

    return Scaffold(
      key: scaffoldKeyRooms,
      backgroundColor: Colors.green.shade100,
      drawer: const CustomDrawer(),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.green.shade800,
        title: const Text('Quartos'),
        /* actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              showDialog(context: context, builder: (_) => SearchDialogg());
            },
          )
        ], */
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.75,
              child: Expanded(
                child: Card(
                  margin: const EdgeInsets.all(10),
                  elevation: 10,
                  color: Colors.white,
                  child: Row(
                    children: [
                      Expanded(child: Consumer<RoomManager>(
                        builder: (_, roomManager, __) {
                          return ListView.builder(
                            itemCount: roomManager.hotelRooms.length,
                            itemBuilder: (_, index) {
                              return RoomListTile(
                                  roomManager.hotelRooms[index]);
                            },
                          );
                        },
                      ))
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const RoomPage()),
          );
        },
        child: const Icon(Icons.add),
        backgroundColor: Colors.green.shade800,
      ),
    );
  }
}
