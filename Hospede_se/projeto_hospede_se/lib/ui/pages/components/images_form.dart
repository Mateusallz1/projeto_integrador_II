import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:projeto_hospede_se/helpers/validators.dart';
import 'package:projeto_hospede_se/models/room.dart';
import 'package:projeto_hospede_se/ui/pages/components/image_source_sheet.dart';
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
      validator: (images) => Validators.validateImage(images!),
      builder: (state) {
        void onImagesSelected(File file) {
          state.value!.add(file);
          state.didChange(state.value);
          Navigator.of(context).pop();
        }

        return Column(
          children: [
            AspectRatio(
              aspectRatio: 1,
              child: CarouselSlider(
                items: List.from(widget.room.images)
                    .map(
                      (e) => ClipRRect(
                        borderRadius: BorderRadius.circular(6),
                        child: Stack(
                          fit: StackFit.expand,
                          children: <Widget>[
                            if (e is String)
                              Image.network(
                                e,
                                fit: BoxFit.cover,
                              )
                            else
                              Image.file(
                                e as File,
                                fit: BoxFit.cover,
                              ),
                            Align(
                              alignment: Alignment.topLeft,
                              child: IconButton(
                                onPressed: () {
                                  state.value!.remove(e);
                                  state.didChange(state.value);
                                },
                                icon: const Icon(Icons.remove_circle_sharp),
                                color: Colors.red.shade600,
                                iconSize: 40,
                              ),
                            ),
                            Align(
                              alignment: Alignment.topRight,
                              child: IconButton(
                                onPressed: () {
                                  showModalBottomSheet(
                                    context: context,
                                    builder: (_) => ImageSourceSheet(
                                      onImagesSelected: onImagesSelected,
                                    ),
                                  );
                                },
                                icon: const Icon(Icons.add_sharp),
                                color: Colors.greenAccent.shade400,
                                iconSize: 40,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
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
            if (state.hasError)
              Text(
                state.errorText.toString(),
                style: const TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                ),
              ),
          ],
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
