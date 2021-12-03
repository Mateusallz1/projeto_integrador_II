import 'dart:async';
import 'dart:io';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:projeto_hospede_se/models/hotel.dart';
import 'package:projeto_hospede_se/models/hotel_manager.dart';
import 'package:projeto_hospede_se/models/room_manager.dart';
import 'package:projeto_hospede_se/services/auth_service.dart';
import 'package:projeto_hospede_se/ui/pages/components/drawer.dart';
import 'package:projeto_hospede_se/ui/styles/style.dart';
import 'package:provider/src/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class StartPage extends StatefulWidget {
  const StartPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldKeyAbode =
        GlobalKey<ScaffoldState>();
    final PageController pageController = PageController();

    String? qtd;

    Future<Hotel> getFutureData() async {
      AuthService auth = context.read<AuthService>();
      HotelManager hotelManager = context.read<HotelManager>();
      RoomManager roomManager = context.read<RoomManager>();
      await hotelManager.loadHotel(auth.getUser().id);
      await roomManager.loadRooms(hotelManager.getHotel().id);
      Hotel hotel = hotelManager.getHotel();
      qtd = roomManager.hotelRooms.length.toString();
      while (hotel.images.isEmpty) {
        await hotelManager.loadHotel(auth.getUser().id);
        hotel = hotelManager.getHotel();
      }
      return hotel;
    }

    Widget buildIndicator(int activeIndex, Hotel hotel) =>
        AnimatedSmoothIndicator(
          activeIndex: activeIndex,
          count: hotel.images.length,
          effect: WormEffect(
              dotColor: Colors.green.shade800,
              activeDotColor: Colors.green.shade300,
              dotWidth: 15,
              dotHeight: 15),
        );

    buildContainer() {
      return FutureBuilder(
          future: getFutureData(),
          builder: (context, AsyncSnapshot<Hotel> snapshot) {
            int activeIndex = 0;
            if (snapshot.hasData && snapshot.data!.images.isNotEmpty) {
              Hotel? hotel = snapshot.data;
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: CarouselSlider(
                      items: hotel!.images
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
                        onPageChanged: (index, reason) =>
                            setState(() => activeIndex = index),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: buildIndicator(activeIndex, hotel),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 5, bottom: 5),
                        child: starsRating(
                          hotel.rating!.toInt(), /* 35 */
                        ),
                      ),
                    ],
                  ),
                  Text(
                    hotel.state == hotel.city
                        ? '${hotel.country}, ${hotel.city}'
                        : '${hotel.country}, ${hotel.state} ${hotel.city}',
                    overflow: TextOverflow.fade,
                    maxLines: 1,
                    softWrap: true,
                    style: GoogleFonts.montserrat(
                        textStyle: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w600)),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 45, right: 45, top: 5, bottom: 10),
                    child: Text(
                      '${hotel.address}',
                      overflow: TextOverflow.fade,
                      maxLines: 2,
                      softWrap: true,
                      style: GoogleFonts.montserrat(
                          textStyle: const TextStyle(fontSize: 15)),
                    ),
                  ),
                  Text(
                    'Quartos: $qtd',
                    overflow: TextOverflow.fade,
                    maxLines: 1,
                    softWrap: true,
                    style: GoogleFonts.montserrat(
                        textStyle: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w600)),
                  ),
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
          });
    }

    return Scaffold(
      key: scaffoldKeyAbode,
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
