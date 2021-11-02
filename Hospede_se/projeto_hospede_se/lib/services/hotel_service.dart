import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:projeto_hospede_se/models/hotel.dart';
import 'package:projeto_hospede_se/models/hotel_manager.dart';
import 'package:flutter/material.dart';

class HotelsProvider extends ChangeNotifier {
  final _hotelsSnapshot = <DocumentSnapshot>[];
  String _errorMessage = '';
  int documentLimit = 15;
  bool _hasNext = true;
  bool _isFetchingHotels = false;

  String get errorMessage => _errorMessage;
  bool get hasNext => _hasNext;

  String _search = '';

  String get search => _search;
  set search(String value) {
    _search = value;
    notifyListeners();
  }

  List<Hotel> get filteredHotel {
    final List<Hotel> filteredHotel = [];

    if (search.isEmpty) {
      filteredHotel.addAll(hotels);
    } else {
      filteredHotel.addAll(hotels.where((p) => p.name!.toLowerCase().contains(search.toLowerCase())));
    }
    return filteredHotel;
  }

  void removeHotels() {
    _hotelsSnapshot.clear();
    // ignore: avoid_print
    print('lista de hoteis removida');
  }

  List<Hotel> get hotels => _hotelsSnapshot.map((snap) {
        final Hotel hotel = Hotel.fromDocument(snap);
        return hotel;
      }).toList();

  Future fetchNextHotels() async {
    if (_isFetchingHotels) return;

    _errorMessage = '';
    _isFetchingHotels = true;

    try {
      final snap = await HotelManager.loadAllHotels(
        documentLimit,
        startAfter: _hotelsSnapshot.isNotEmpty ? _hotelsSnapshot.last : null,
      );
      _hotelsSnapshot.addAll(snap.docs);

      if (snap.docs.length < documentLimit) _hasNext = false;
      notifyListeners();
    } catch (error) {
      _errorMessage = error.toString();
      notifyListeners();
    }

    _isFetchingHotels = false;
  }
}
