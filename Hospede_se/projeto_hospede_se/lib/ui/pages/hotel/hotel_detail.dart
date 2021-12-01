import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:projeto_hospede_se/models/hotel.dart';
import 'package:projeto_hospede_se/ui/pages/components/room_list.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

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
            CarouselSlider(
              items: widget.hotel.images
                  .map((e) => ClipRRect(
                        borderRadius: BorderRadius.circular(6),
                        child: Stack(
                          fit: StackFit.expand,
                          children: <Widget>[
                            if (e is String)
                              Image.network(
                                e,
                                width: 650,
                                height: 350,
                                fit: BoxFit.cover,
                              )
                            else
                              Image.file(
                                e as File,
                                fit: BoxFit.cover,
                              ),
                          ],
                        ),
                      ))
                  .toList(),
              options: CarouselOptions(
                initialPage: 0,
                autoPlay: true,
                enableInfiniteScroll: false,
                disableCenter: true,
                aspectRatio: 16 / 9,
                autoPlayCurve: Curves.fastOutSlowIn,
                onPageChanged: (index, reason) => setState(() => activeIndex = index),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: buildIndicator(),
                ),
              ],
            ),
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

  Widget buildIndicator() => AnimatedSmoothIndicator(
        activeIndex: activeIndex,
        count: widget.hotel.images.length,
        effect: WormEffect(
            dotColor: Colors.green.shade800, activeDotColor: Colors.green.shade300, dotWidth: 15, dotHeight: 15),
      );
}
