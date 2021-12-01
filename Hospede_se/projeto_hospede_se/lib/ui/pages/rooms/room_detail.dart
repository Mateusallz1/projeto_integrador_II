import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:projeto_hospede_se/models/room.dart';
import 'package:projeto_hospede_se/services/auth_service.dart';
import 'package:projeto_hospede_se/ui/pages/rooms/edit_room.dart';
import 'package:projeto_hospede_se/ui/styles/style.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class RoomScreen extends StatefulWidget {
  // ignore: use_key_in_widget_constructors
  const RoomScreen(this.room);
  final Room room;

  @override
  State<RoomScreen> createState() => RoomPageState();
}

class RoomPageState extends State<RoomScreen> {
  int activeIndex = 0;

  @override
  Widget build(BuildContext context) {
    AuthService auth = Provider.of<AuthService>(context);
    bool? host = auth.getUser().host!;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green.shade800,
        title: Text(widget.room.title.toString()),
        centerTitle: true,
        actions: <Widget>[
          Builder(
            builder: (context) {
              if (host) {
                return IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditRoomPage(
                          room: widget.room,
                        ),
                      ),
                    );
                  },
                );
              } else {
                return Container();
              }
            },
          )
        ],
      ),
      body: ListView(
        children: [
          CarouselSlider(
            items: widget.room.images
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
          Padding(
            padding: const EdgeInsets.only(top: 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  widget.room.title.toString(),
                  style: GoogleFonts.montserrat(
                    textStyle: const TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(10),
                  child: Text(
                    widget.room.description.toString(),
                    style: GoogleFonts.montserrat(
                      textStyle: const TextStyle(fontSize: 20),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      iconCard(Icons.person_outlined, widget.room.guestCount.toString()),
                      iconCard(Icons.bed, widget.room.bedCount.toString()),
                      iconCard(Icons.bathtub_outlined, widget.room.bathCount.toString()),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 27),
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: ElevatedButton(
                      child: const Text(
                        'Reservar',
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                      onPressed: () {},
                      style: elevatedButtonConfirm),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildIndicator() => AnimatedSmoothIndicator(
        activeIndex: activeIndex,
        count: widget.room.images.length,
        effect: WormEffect(
            dotColor: Colors.green.shade800, activeDotColor: Colors.green.shade300, dotWidth: 15, dotHeight: 15),
      );
}
