import 'package:flutter/material.dart';
import 'package:projeto_hospede_se/helpers/validators.dart';

class ExploreUserPage extends StatefulWidget {
  const ExploreUserPage({Key? key}) : super(key: key);

  @override
  State<ExploreUserPage> createState() => _ExploreUserPage();
}

class _ExploreUserPage extends State<ExploreUserPage> {
  final searchkey = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

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
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 40),
                  child: Form(
                    child: TextFormField(
                      controller: searchkey,
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                        hintText: 'Cidade, Estado, País',
                        labelStyle: TextStyle(color: Colors.white),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.all(
                            Radius.circular(5),
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.all(
                            Radius.circular(5),
                          ),
                        ),
                      ),
                      validator: (name) => Validators.validateName(name!),
                    ),
                  ),
                ),
                IconButton(
                  color: Colors.white,
                  onPressed: dateTimeRangePicker,
                  icon: const Icon(Icons.calendar_today),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
