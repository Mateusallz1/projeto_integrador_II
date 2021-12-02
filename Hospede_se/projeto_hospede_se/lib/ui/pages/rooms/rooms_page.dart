import 'package:flutter/material.dart';
import 'package:projeto_hospede_se/models/hotel_manager.dart';
import 'package:projeto_hospede_se/models/room_manager.dart';
import 'package:projeto_hospede_se/ui/pages/components/search_dialog.dart';
import 'package:projeto_hospede_se/ui/pages/rooms/registration_room.dart';
import 'package:projeto_hospede_se/services/auth_service.dart';
import 'package:projeto_hospede_se/ui/pages/components/drawer.dart';
import 'package:projeto_hospede_se/ui/pages/components/room_list_tile.dart';
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
      backgroundColor: Colors.grey.shade50,
      drawer: const CustomDrawer(),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.green.shade800,
        title: const Text('Quartos'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () async {
              final search = await showDialog<String>(
                  context: context, builder: (_) => const SearchDialogg());

              if (search != null) {
                context.read<RoomManager>().search = search;
              }
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 1,
              child: Expanded(
                child: Row(
                  children: [
                    Expanded(child: Consumer<RoomManager>(
                      // Achar um jeito de não chamar o get 2 vezes
                      builder: (_, roomManager, __) {
                        return ListView.builder(
                          itemCount: roomManager.hotelRooms.length,
                          itemBuilder: (_, index) {
                            return RoomListTile(roomManager.hotelRooms[index]);
                          },
                        );
                      },
                    ))
                  ],
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
