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
        centerTitle: true,
        title: Text(
          "Hotéis Disponíveis",
          style: GoogleFonts.montserrat(
            textStyle: TextStyle(
              color: Colors.green.shade800,
            ),
          ),
        ),
        backgroundColor: Colors.grey.shade50,
      ),
      body: Theme(
        data: Theme.of(context).copyWith(
          colorScheme:
              const ColorScheme.light(primary: Colors.green, secondary: Colors.green, background: Colors.white),
        ),
        child: Consumer<HotelsProvider>(
          builder: (context, hotelsProvider, _){
            hotelsProvider.booking = widget.booking;

            return ListViewHotelWidget(
              hotelsProvider: hotelsProvider,
              typesearch: 2,
            );
           }
        ),
      ),
    );
  }
}
