import 'package:flutter/material.dart';
import 'package:projeto_hospede_se/styles/style.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
//import 'package:flutter_localizations/flutter_localizations.dart';

class StartUserPage extends StatefulWidget {
  const StartUserPage({Key? key}) : super(key: key);

  @override
  State<StartUserPage> createState() => _StartUserPage();
}

class _StartUserPage extends State<StartUserPage> {
  dateTimeRangePicker() async {
    return showDateRangePicker(
      context: context,
      //locale: const Locale('pt', 'BR'),
      firstDate: DateTime(DateTime.now().year - 5),
      lastDate: DateTime(DateTime.now().year + 5),
      // initialDateRange: DateTimeRange(
      //   end: DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day + 1),
      //   start: DateTime.now(),
      // ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Theme(
        data: Theme.of(context).copyWith(
          colorScheme: const ColorScheme.light(primary: Colors.green, secondary: Colors.green, background: Colors.white),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
              style: elevatedButton,
              onPressed: () {
                dateTimeRangePicker();
              },
              child: const Text("DateRange Picker"),
            ),
          ],
        ),
      ),
    );
  }
}
