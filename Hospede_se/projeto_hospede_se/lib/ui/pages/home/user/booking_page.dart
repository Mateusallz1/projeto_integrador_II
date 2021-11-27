import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:projeto_hospede_se/services/hotel_service.dart';
import 'package:projeto_hospede_se/widgets/listview_hotels.dart';
import 'package:provider/provider.dart';

class BookingPage extends StatefulWidget {
  final Map booking;
  const BookingPage({required this.booking, Key? key}) : super(key: key);

  @override
  State<BookingPage> createState() => _BookingPage();
}

class _BookingPage extends State<BookingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Hotéis Disponíveis",
          style: GoogleFonts.montserrat(
            textStyle: const TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        backgroundColor: Colors.green.shade800,
      ),
      body: Consumer<HotelsProvider>(builder: (context, hotelsProvider, _) {
        hotelsProvider.booking = widget.booking;

        return ListViewHotelWidget(
          hotelsProvider: hotelsProvider,
          typesearch: 2,
        );
      }),
    );
  }
}
