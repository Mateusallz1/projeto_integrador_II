import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:projeto_hospede_se/models/hotel.dart';
import 'package:projeto_hospede_se/pages/components/room_list.dart';

class HotelScreen extends StatefulWidget {
  // ignore: use_key_in_widget_constructors
  const HotelScreen(this.hotel);
  final Hotel hotel;

  @override
  State<HotelScreen> createState() => HotelPageState();
}

class HotelPageState extends State<HotelScreen> {
  int activeIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green.shade800,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.height * 1,
              height: MediaQuery.of(context).size.height * 0.55,
              child: Padding(
                padding: const EdgeInsets.only(top: 15),
                child: Column(
                  children: [
                    Text(
                      widget.hotel.name.toString(),
                      style: GoogleFonts.montserrat(
                          textStyle: const TextStyle(fontSize: 35, fontWeight: FontWeight.bold)),
                    ),
                    Container(
                      margin: const EdgeInsets.all(10),
                      child: Text(
                        widget.hotel.address.toString(),
                        style: GoogleFonts.montserrat(textStyle: const TextStyle(fontSize: 20)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Text(
                    'Quartos Disponíveis',
                    style: GoogleFonts.montserrat(
                        textStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  ),
                ),
              ],
            ),
            RoomListView(widget.hotel),
          ],
        ),
      ),
    );
  }
}
