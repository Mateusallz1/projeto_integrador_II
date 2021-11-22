import 'dart:async';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_places_hoc081098/flutter_google_places_hoc081098.dart';
import 'package:google_api_headers/google_api_headers.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:projeto_hospede_se/helpers/map_address.dart';
import 'package:projeto_hospede_se/helpers/validators.dart';
import 'package:number_selection/number_selection.dart';
import 'package:projeto_hospede_se/pages/home/user/booking_page.dart';
import 'package:projeto_hospede_se/services/hotel_service.dart';
import 'package:projeto_hospede_se/styles/style.dart';
import 'package:provider/provider.dart';

class SearchUserPage extends StatefulWidget {
  const SearchUserPage({Key? key}) : super(key: key);

  @override
  State<SearchUserPage> createState() => _SearchUserPage();
}

class _SearchUserPage extends State<SearchUserPage> {
  final kGoogleApiKey = "AIzaSyCVeWR8xFrJtYK1jaCHXUXclOTIvjLxbZw";

  Map _booking = {};
  Map _searchAddress = {};
  Map _date = {};
  final _searchkey = TextEditingController();
  final _firstdate = TextEditingController();
  final _lastdate = TextEditingController();
  final _quantity = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  Future<void> _dateTimeRangePicker() async {
    DateFormat dateformat = DateFormat('dd/MM/yyyy');
    DateTimeRange? picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime(DateTime.now().year - 5),
      lastDate: DateTime(DateTime.now().year + 5),
    );

    if (picked != null) {
      DateTime start = picked.start;
      DateTime end = picked.end;

      _firstdate.text = dateformat.format(start).toString();
      _lastdate.text = dateformat.format(end).toString();

      _date = {'start': start, 'end': end};
    }
  }

  Future<void> _handlePressButton() async {
    void onError(PlacesAutocompleteResponse response) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(response.errorMessage ?? 'Unknown error'),
        ),
      );
    }

    final p = await PlacesAutocomplete.show(
      context: context,
      apiKey: kGoogleApiKey,
      onError: onError,
      mode: Mode.overlay,
      language: 'en',
      // components: [Component(Component.country, 'br')],
    );

    await displayPrediction(p, ScaffoldMessenger.of(context));
  }

  Future<void> displayPrediction(Prediction? p, ScaffoldMessengerState messengerState) async {
    if (p == null) {
      return;
    }

    final _places = GoogleMapsPlaces(
      apiKey: kGoogleApiKey,
      apiHeaders: await const GoogleApiHeaders().getHeaders(),
    );

    final detail = await _places.getDetailsByPlaceId(p.placeId!);
    final flongname = detail.result.addressComponents.first.longName;
    final fshortname = detail.result.addressComponents.last.shortName;
    final llongname = detail.result.addressComponents.last.longName;
    final lshortname = detail.result.addressComponents.last.shortName;

    _searchkey.text = p.description.toString();

    _searchAddress = {
      'description': p.description,
      'flongname': flongname,
      'fshortname': fshortname,
      'llongname': llongname,
      'lshortname': lshortname,
    };
    _searchAddress = mapAddress(_searchAddress);
  }

  bookingSearch(HotelsProvider hotelsProvider) async {
    _booking = {
      'description': _searchAddress['description'],
      'flongname': _searchAddress['flongname'],
      'fshortname': _searchAddress['flongname'],
      'llongname': _searchAddress['llongname'],
      'lshortname': _searchAddress['lshortname'],
      'startdate': _date['start'],
      'enddate': _date['end'],
      'quantity': _quantity
    };

    Navigator.push(context, MaterialPageRoute(builder: (context) => BookingPage(booking: _booking)));
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
              height: MediaQuery.of(context).size.height * 0.55,
              decoration: BoxDecoration(
                color: Colors.green.shade800,
                shape: BoxShape.rectangle,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(15),
                  bottomRight: Radius.circular(15),
                ),
              ),
              child: Consumer<HotelsProvider>(
                builder: (context, hotelsProvider, _) => Padding(
                  padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
                  child: Column(
                    children: [
                      Form(
                        key: formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextFormField(
                              readOnly: true,
                              controller: _searchkey,
                              style: const TextStyle(color: Colors.black),
                              onTap: () {
                                _handlePressButton();
                              },
                              validator: (search) => Validators.validateText(search!),
                              decoration: inputDecorationBooking('Para onde você está indo?'),
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 10),
                              child: Column(
                                children: [
                                  TextFormField(
                                    readOnly: true,
                                    enabled: true,
                                    controller: _firstdate,
                                    style: const TextStyle(color: Colors.black),
                                    decoration: inputDecorationBookingIcon('Data Inicial', Icons.date_range),
                                    validator: (firstdate) => Validators.validateText(firstdate!),
                                    onTap: _dateTimeRangePicker,
                                  ),
                                  TextFormField(
                                    readOnly: true,
                                    controller: _lastdate,
                                    style: const TextStyle(color: Colors.black),
                                    decoration: inputDecorationBookingIcon('Data Final', Icons.date_range),
                                    validator: (lastdate) => Validators.validateText(lastdate!),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 10),
                              padding: const EdgeInsets.all(5),
                              color: Colors.white,
                              child: Column(
                                children: [
                                  Text(
                                    'Selecione a quantidade de hóspedes',
                                    style: TextStyle(fontSize: 16, color: Colors.grey.shade700),
                                  ),
                                  Container(
                                    width: MediaQuery.of(context).size.height * 1,
                                    height: MediaQuery.of(context).size.height * 0.07,
                                    margin: const EdgeInsets.only(top: 10),
                                    child: NumberSelection(
                                      theme: NumberSelectionTheme(
                                          draggableCircleColor: Colors.green.shade800,
                                          iconsColor: Colors.green.shade800,
                                          numberColor: Colors.white,
                                          backgroundColor: Colors.white,
                                          outOfConstraintsColor: Colors.deepOrange),
                                      initialValue: 1,
                                      minValue: 1,
                                      maxValue: 15,
                                      direction: Axis.horizontal,
                                      withSpring: true,
                                      onChanged: (value) => {
                                        _quantity.text = value.toString(),
                                      },
                                      enableOnOutOfConstraintsAnimation: false,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 27),
                              width: MediaQuery.of(context).size.height * 1,
                              child: ElevatedButton(
                                  child: Text(
                                    'Pesquisar',
                                    style: TextStyle(fontSize: 20, color: Colors.green.shade800),
                                  ),
                                  onPressed: () {
                                    if (formKey.currentState!.validate()) {
                                      formKey.currentState!.save();
                                      bookingSearch(hotelsProvider);
                                    }
                                  },
                                  style: elevatedButtonConfirmWhite),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
