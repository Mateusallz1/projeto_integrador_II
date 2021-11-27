import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:projeto_hospede_se/ui/pages/components/search_dialog.dart';
import 'package:projeto_hospede_se/services/hotel_service.dart';
import 'package:projeto_hospede_se/widgets/listview_hotels.dart';
import 'package:provider/provider.dart';

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
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Hotéis",
          style: GoogleFonts.montserrat(
            textStyle: const TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        backgroundColor: Colors.green.shade800,
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            color: Colors.green.shade800,
            onPressed: () async {
              final search = await showDialog<String>(context: context, builder: (_) => const SearchDialogg());

              if (search != null) {
                context.read<HotelsProvider>().search = search;
              }
            },
          )
        ],
      ),
      body: Theme(
        data: Theme.of(context).copyWith(
          colorScheme:
              const ColorScheme.light(primary: Colors.green, secondary: Colors.green, background: Colors.white),
        ),
        child: Consumer<HotelsProvider>(
          builder: (context, hotelsProvider, _) => ListViewHotelWidget(
            hotelsProvider: hotelsProvider,
            typesearch: 1,
          ),
        ),
      ),
    );
  }
}
