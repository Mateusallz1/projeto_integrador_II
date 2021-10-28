import 'package:flutter/material.dart';
import 'package:projeto_hospede_se/services/hotel_service.dart';

class ListViewHotelWidget extends StatefulWidget {
  final HotelsProvider hotelsProvider;

  const ListViewHotelWidget({
    required this.hotelsProvider,
    Key? key,
  }) : super(key: key);

  @override
  _ListViewHotelWidgetState createState() => _ListViewHotelWidgetState();
}

class _ListViewHotelWidgetState extends State<ListViewHotelWidget> {
  final scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    scrollController.addListener(scrollListener);
    widget.hotelsProvider.fetchNextHotels();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  void scrollListener() {
    if (scrollController.offset >= scrollController.position.maxScrollExtent / 2 && !scrollController.position.outOfRange) {
      if (widget.hotelsProvider.hasNext) {
        widget.hotelsProvider.fetchNextHotels();
      }
    }
  }

  @override
  Widget build(BuildContext context) => ListView(
        controller: scrollController,
        padding: const EdgeInsets.all(12),
        children: [
          ...widget.hotelsProvider.hotels
              .map((hotel) => ListTile(
                    title: Text(hotel.name!),
                    // leading: CircleAvatar(
                    //   backgroundImage: NetworkImage(user.imageUrl),
                    // ),
                  ))
              .toList(),
          if (widget.hotelsProvider.hasNext)
            Center(
              child: GestureDetector(
                onTap: widget.hotelsProvider.fetchNextHotels,
                child: const SizedBox(
                  height: 25,
                  width: 25,
                  child: CircularProgressIndicator(),
                ),
              ),
            ),
        ],
      );
}
