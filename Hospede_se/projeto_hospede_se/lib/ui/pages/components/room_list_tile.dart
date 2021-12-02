import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:projeto_hospede_se/models/room.dart';
import 'package:projeto_hospede_se/models/room_manager.dart';
import 'package:projeto_hospede_se/ui/pages/rooms/room_detail.dart';
import 'package:projeto_hospede_se/services/auth_service.dart';
import 'package:projeto_hospede_se/ui/styles/style.dart';
import 'package:provider/provider.dart';

class RoomListTile extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const RoomListTile(this.room);
  final Room room;

  @override
  Widget build(BuildContext context) {
    AuthService auth = Provider.of<AuthService>(context);
    bool? host = auth.getUser().host!;

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => RoomScreen(room)),
        );
      },
      child: Card(
        elevation: 20,
        shape: RoundedRectangleBorder(
          side: BorderSide(color: Colors.green.shade800, width: 0),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Container(
          padding: const EdgeInsets.all(5),
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.045,
                child: Expanded(
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.only(left: 7),
                        width: MediaQuery.of(context).size.width * 0.9,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              room.title!,
                              overflow: TextOverflow.fade,
                              maxLines: 1,
                              softWrap: false,
                              style: GoogleFonts.montserrat(
                                textStyle: const TextStyle(
                                    fontSize: 25, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.15,
                child: Row(
                  children: [
                    AspectRatio(
                      aspectRatio: 1,
                      child: Consumer<RoomManager>(
                        builder: (_, roomManager, __) {
                          if (room.images.isEmpty) {
                            List<Room> listRooms = roomManager.filteredRooms;
                            listRooms.forEach(
                              (element) {
                                if (element.id == room.id) {
                                  room.images = element.images;
                                }
                              },
                            );
                          }
                          return Image.network(
                            room.images.first,
                          );
                        },
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Card(
                              elevation: 0,
                              child: SingleChildScrollView(
                                padding: const EdgeInsets.all(3),
                                child: Column(
                                  children: [
                                    Text(
                                      host
                                          ? 'Quantidade: ${room.quantity}\n'
                                              'Capacidade: ${room.guestCount}'
                                          : 'Capacidade: ${room.guestCount}',
                                      overflow: TextOverflow.fade,
                                      maxLines: 2,
                                      softWrap: true,
                                      style: GoogleFonts.montserrat(
                                        textStyle: const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          if (host)
                            Expanded(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  cardStatus(room.status!, host),
                                  cardBookin(room.price!.toStringAsFixed(2))
                                ],
                              ),
                            ),
                            
                          if (!host)
                            Expanded(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  cardBookin(room.price!.toStringAsFixed(2))
                                ],
                              ),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
