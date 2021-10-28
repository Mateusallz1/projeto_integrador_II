import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'package:projeto_hospede_se/services/hotel_service.dart';
import 'package:projeto_hospede_se/widgets/listview_hotels.dart';
import 'package:provider/provider.dart';
=======
import 'package:projeto_hospede_se/models/hotel_manager.dart';
import 'package:provider/provider.dart';
import 'package:provider/src/provider.dart';
>>>>>>> 45a9da373d17bb9d6f4934327505e0e3e4611d19

class StartUserPage extends StatefulWidget {
  const StartUserPage({Key? key}) : super(key: key);

  @override
  State<StartUserPage> createState() => _StartUserPage();
}

class _StartUserPage extends State<StartUserPage> {
  dateTimeRangePicker() async {
    return showDateRangePicker(
      context: context,
      firstDate: DateTime(DateTime.now().year - 5),
      lastDate: DateTime(DateTime.now().year + 5),
    );
  }

  @override
  Widget build(BuildContext context) {
    /* HotelManager hotelManager = context.read<HotelManager>();
    hotelManager.getAllHotels(); */

    return Scaffold(
      body: Theme(
        data: Theme.of(context).copyWith(
          colorScheme: const ColorScheme.light(primary: Colors.green, secondary: Colors.green, background: Colors.white),
        ),
        child: Consumer<HotelsProvider>(
          builder: (context, hotelsProvider, _) => ListViewHotelWidget(
            hotelsProvider: hotelsProvider,
          ),
        ),
      ),
    );
  }
}
