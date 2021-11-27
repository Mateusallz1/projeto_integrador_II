import 'package:flutter/material.dart';
import 'package:projeto_hospede_se/ui/pages/components/hotel_list_tile.dart';
import 'package:projeto_hospede_se/services/hotel_service.dart';

class ListViewHotelWidget extends StatefulWidget {
  final HotelsProvider hotelsProvider;
  final int typesearch;

  const ListViewHotelWidget({
    required this.hotelsProvider,
    required this.typesearch,
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
    widget.hotelsProvider.fetchNextHotels(widget.typesearch);
    //widget.hotelsProvider.removeHotels();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  void scrollListener() {
    if (scrollController.offset >= scrollController.position.maxScrollExtent / 2 &&
        !scrollController.position.outOfRange) {
      if (widget.hotelsProvider.hasNext) {
        widget.hotelsProvider.fetchNextHotels(widget.typesearch);
      }
    }
  }

  @override
  Widget build(BuildContext context) => ListView(
        controller: scrollController,
        children: [
          ...widget.hotelsProvider.getHotels().map((hotel) => HotelListTile(hotel)).toList(),
          if (widget.hotelsProvider.hasNext)
            Center(
              child: GestureDetector(
                onTap: () {
                  widget.hotelsProvider.fetchNextHotels(widget.typesearch);
                },
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: SizedBox(
                    height: 25,
                    width: 25,
                    child: CircularProgressIndicator(),
                  ),
                ),
              ),
            ),
        ],
      );
}
