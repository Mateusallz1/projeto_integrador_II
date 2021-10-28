import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:projeto_hospede_se/helpers/validators.dart';
import 'package:projeto_hospede_se/styles/style.dart';

class ExploreUserPage extends StatefulWidget {
  const ExploreUserPage({Key? key}) : super(key: key);

  @override
  State<ExploreUserPage> createState() => _ExploreUserPage();
}

class _ExploreUserPage extends State<ExploreUserPage> {
  final searchkey = TextEditingController();
  final firstdate = TextEditingController();
  final lastdate = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  dateTimeRangePicker() async {
    DateFormat dateformat = DateFormat('dd/MM/yyyy');
    DateTimeRange? picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime(DateTime.now().year - 5),
      lastDate: DateTime(DateTime.now().year + 5),
    );

    if (picked != null) {
      DateTime start = picked.start;
      DateTime end = picked.end;

      firstdate.text = dateformat.format(start).toString();
      lastdate.text = dateformat.format(end).toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: scaffoldKey,
        body: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.height * 1,
              height: MediaQuery.of(context).size.height * 0.5,
              decoration: const BoxDecoration(
                color: Colors.green,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(15),
                  bottomRight: Radius.circular(15),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 40, left: 20, right: 20),
                child: Column(
                  children: [
                    Form(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextFormField(
                            controller: searchkey,
                            style: const TextStyle(color: Colors.black),
                            decoration: inputDecorationRadiusWhite('Localização'),
                            validator: (search) => Validators.validateText(search!),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 10),
                            child: IconButton(
                              color: Colors.white,
                              onPressed: dateTimeRangePicker,
                              icon: const Icon(Icons.calendar_today),
                            ),
                          ),
                          TextFormField(
                            enabled: false,
                            controller: firstdate,
                            style: const TextStyle(color: Colors.black),
                            decoration: inputDecorationRadiusWhite('Data Inicial'),
                            validator: (firstdate) => Validators.validateText(firstdate!),
                          ),
                          TextFormField(
                            enabled: false,
                            controller: lastdate,
                            style: const TextStyle(color: Colors.black),
                            decoration: inputDecorationRadiusWhite('Data Final'),
                            validator: (lastdate) => Validators.validateText(lastdate!),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
