import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:projeto_hospede_se/models/booking.dart';
import 'package:projeto_hospede_se/models/booking_type.dart';
import 'package:projeto_hospede_se/models/hotel.dart';
import 'package:projeto_hospede_se/models/hotel_manager.dart';

class BookingListTile extends StatefulWidget {
  // ignore: use_key_in_widget_constructors
  const BookingListTile(this.booking);
  final Booking booking;

  @override
  State<BookingListTile> createState() => _BookingListTileState();
}

class _BookingListTileState extends State<BookingListTile> {
  @override
  Widget build(BuildContext context) {
    DateFormat dateformat = DateFormat('dd/MM/yyyy');
    String startdate = dateformat.format(widget.booking.startdate!);
    String enddate = dateformat.format(widget.booking.startdate!);

    return Card(
      elevation: 20,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Colors.green.shade800, width: 0),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Container(
        padding: const EdgeInsets.all(5),
        child: Column(
          children: [
            Text(widget.booking.roomName!),
            Text('de ' + startdate + ' a ' + enddate),
            Text('R\$ ' + widget.booking.bookingPrice!.toStringAsFixed(2)),
            widget.booking.bookingtype == bookingType(0)
                ? ElevatedButton(onPressed: () {}, child: Text('Cancelar Reserva'))
                : Text(''),
          ],
        ),
      ),
    );
  }
}
