import 'package:flutter/material.dart';
import 'package:projeto_hospede_se/models/hotel.dart';
import 'package:projeto_hospede_se/models/hotel_manager.dart';
import 'package:projeto_hospede_se/models/room.dart';
import 'package:projeto_hospede_se/models/room_manager.dart';
import 'package:projeto_hospede_se/ui/pages/components/drawer.dart';
import 'package:projeto_hospede_se/ui/pages/components/room_list_tile.dart';
import 'package:provider/provider.dart';

class RoomListView extends StatefulWidget {
  // ignore: use_key_in_widget_constructors
  const RoomListView(this.hotel);
  final Hotel hotel;

  @override
  State<RoomListView> createState() => _RoomListViewState();
}

class _RoomListViewState extends State<RoomListView> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    RoomManager roomManager = context.read<RoomManager>();
    roomManager.loadRooms(widget.hotel.id);

    Future<List<Room>> getFutureRooms() async {
      HotelManager hotelManager = context.read<HotelManager>();
      RoomManager roomManager = context.read<RoomManager>();
      await roomManager.loadRooms(hotelManager.getHotel().id);
      return roomManager.hotelRooms;
    }

    buildContainer() {
      return FutureBuilder(
        future: getFutureRooms(),
        builder: (context, AsyncSnapshot<List<Room>> snapshot) {
          if (snapshot.hasData) {
            List<Room>? rooms = snapshot.data;
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SingleChildScrollView(
                  child: Expanded(
                    child: Row(
                      children: [
                        Expanded(
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: rooms!.length,
                            itemBuilder: (_, index) {
                              return RoomListTile(rooms[index]);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            );
          } else {
            return const Center(
              child: Padding(
                padding: EdgeInsets.all(10),
                child: CircularProgressIndicator(),
              ),
            );
          }
        },
      );
    }

    return Scaffold(
      key: scaffoldKey,
      drawer: const CustomDrawer(),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.green.shade800,
      ),
      body: SingleChildScrollView(
        child: buildContainer(),
      ),
    );
  }
}
  // return Column(
  //   mainAxisAlignment: MainAxisAlignment.start,
  //   crossAxisAlignment: CrossAxisAlignment.start,
  //   children: [
  //     SizedBox(
  //       child: SingleChildScrollView(
  //         child: Expanded(
  //           child: Row(
  //             children: [
  //               Expanded(
  //                 child: Consumer<RoomManager>(
  //                   builder: (_, roomManager, __) {
  //                     return ListView.builder(
  //                       shrinkWrap: true,
  //                       itemCount: roomManager.hotelRooms.length,
  //                       itemBuilder: (_, index) {
  //                         return RoomListTile(roomManager.hotelRooms[index]);
  //                       },
  //                     );
  //                   },
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ),
  //       ),
  //     ),
  //   ],
  // );