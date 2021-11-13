import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:projeto_hospede_se/models/hotel.dart';
import 'package:projeto_hospede_se/styles/style.dart';

class HotelListTile extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const HotelListTile(this.hotel);
  final Hotel hotel;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Card(
        elevation: 20,
        child: Container(
          margin: const EdgeInsets.all(5),
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.045,
                child: Expanded(
                    child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.only(left: 7),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            hotel.name!,
                            overflow: TextOverflow.fade,
                            maxLines: 1,
                            softWrap: false,
                            style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.w500,
                              textStyle: const TextStyle(
                                fontSize: 25,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                )),
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.15,
                margin: const EdgeInsets.all(5),
                child: Row(
                  children: [
                    AspectRatio(
                      aspectRatio: 1.2,
                      child: Image.network('https://www.ahstatic.com/photos/9399_ho_00_p_1024x768.jpg'),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Expanded(
                            child: Card(
                              elevation: 0,
                              child: Padding(
                                padding: const EdgeInsets.all(3),
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 5, bottom: 5),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [starsRating(hotel.rating)],
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(10),
                                          child: Icon(
                                            Icons.place,
                                            color: Colors.green.shade800,
                                          ),
                                        ),
                                        Text(
                                          hotel.state == hotel.city ? '${hotel.country}, ${hotel.city}' : '${hotel.country}, ${hotel.state}\n${hotel.city}',
                                          overflow: TextOverflow.fade,
                                          maxLines: 3,
                                          softWrap: true,
                                          style: GoogleFonts.montserrat(textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          /* Expanded(
                            child: butt) */
                        ],
                      ),
                    )
                  ],
                ),
              ),
              //COLOCAR VALORES HOTEL
            ],
          ),
        ),
      ),
    );
  }
}
