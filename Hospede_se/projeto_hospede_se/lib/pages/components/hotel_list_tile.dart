import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:projeto_hospede_se/models/hotel.dart';

class HotelListTile extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const HotelListTile(this.hotel);
  final Hotel hotel;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(side: BorderSide(color: Colors.grey.shade900, width: 3), borderRadius: BorderRadius.circular(10)),
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
                            hotel.name!,
                            overflow: TextOverflow.fade,
                            maxLines: 1,
                            softWrap: false,
                            style: GoogleFonts.lobster(
                              textStyle: const TextStyle(
                                fontSize: 25,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '${hotel.rating}',
                              ),
                              const Icon(
                                Icons.star,
                                size: 15,
                                color: Colors.yellow,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                )),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.15,
                child: Row(
                  children: [
                    const AspectRatio(
                      aspectRatio: 1,
                      //child: Image.network(hotel.images!.first),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Card(
                              elevation: 0.5,
                              child: Padding(
                                padding: const EdgeInsets.all(3),
                                child: Column(
                                  children: [
                                    Text(
                                      '${hotel.country} \n${hotel.city}\n${hotel.address}\nFone: ${hotel.phone}',
                                      overflow: TextOverflow.fade,
                                      maxLines: 4,
                                      softWrap: true,
                                      style: GoogleFonts.montserrat(textStyle: const TextStyle(fontSize: 16)),
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
            ],
          ),
        ),
      ),
    );
  }
}
