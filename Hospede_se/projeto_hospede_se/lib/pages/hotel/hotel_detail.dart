import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:projeto_hospede_se/models/hotel.dart';

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
      body: ListView(
        children: [
          const SizedBox(
            height: 32,
          ),
          Padding(
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
          )
        ],
      ),
    );
  }
}
