import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:projeto_hospede_se/models/room.dart';

class RoomListTile extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const RoomListTile(this.room);

  final Room room;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed('/room', arguments: room);
      },
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          side: BorderSide(color: Colors.grey.shade900, width: 3),
          borderRadius: BorderRadius.circular(10),
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
                        width: MediaQuery.of(context).size.height * 0.35,
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
                                  fontSize: 25,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Card(
                          elevation: 5,
                          //color: Colors.green.shade100,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              (room.status == true)
                                  ? Text(
                                      'Ativo',
                                      style: GoogleFonts.montserrat(
                                        textStyle: TextStyle(
                                            color: Colors.green.shade900,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    )
                                  : Text(
                                      'Inativo',
                                      style: GoogleFonts.montserrat(
                                        textStyle: TextStyle(
                                            color: Colors.red.shade900, fontSize: 18, fontWeight: FontWeight.bold),
                                      ),
                                    ),
                            ],
                          ),
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
                      child: Image.network(room.images.first),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Card(
                              elevation: 0.5,
                              // shape: RoundedRectangleBorder(
                              //   side: BorderSide(color: Colors.grey.shade900, width: 2),
                              //   borderRadius: BorderRadius.circular(5),
                              // ),
                              child: Padding(
                                padding: const EdgeInsets.all(3),
                                child: Column(
                                  children: [
                                    Text(
                                      room.description!,
                                      overflow: TextOverflow.fade,
                                      maxLines: 3,
                                      softWrap: true,
                                      style: GoogleFonts.montserrat(
                                        textStyle: const TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Row(
                              children: [
                                Card(
                                  elevation: 3,
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide(color: Colors.grey.shade900, width: 2),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(5),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Quantidade: ${room.quantity}\n'
                                          'Capacidade: ${room.guestCount}',
                                          overflow: TextOverflow.fade,
                                          maxLines: 2,
                                          softWrap: true,
                                          style: GoogleFonts.montserrat(
                                            textStyle: const TextStyle(
                                              fontSize: 15,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Card(
                                    elevation: 3,
                                    shape: RoundedRectangleBorder(
                                      side: BorderSide(color: Colors.grey.shade900, width: 2),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(5),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            '${room.price} BRL',
                                            overflow: TextOverflow.fade,
                                            maxLines: 1,
                                            softWrap: false,
                                            style: GoogleFonts.montserrat(
                                              textStyle:
                                                  const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
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
            ],
          ),
        ),
      ),
    );
  }
}
