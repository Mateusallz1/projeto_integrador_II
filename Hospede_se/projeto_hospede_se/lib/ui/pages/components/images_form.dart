import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:projeto_hospede_se/models/room.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ImagesForm extends StatefulWidget {
  const ImagesForm({Key? key, required this.room}) : super(key: key);

  final Room room;

  @override
  State<ImagesForm> createState() => _ImagesFormState();
}

class _ImagesFormState extends State<ImagesForm> {
  int activeIndex = 0;

  @override
  Widget build(BuildContext context) {
    return FormField<List<dynamic>>(
      initialValue: widget.room.images,
      builder: (state) {
        return CarouselSlider(
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
            onPageChanged: (index, reason) =>
                setState(() => activeIndex = index),
          ),
        );
      },
    );
  }

  Widget buildIndicator() => AnimatedSmoothIndicator(
        activeIndex: activeIndex,
        count: widget.room.images.length,
        effect: WormEffect(
            dotColor: Colors.green.shade800,
            activeDotColor: Colors.green.shade300,
            dotWidth: 15,
            dotHeight: 15),
      );
}
