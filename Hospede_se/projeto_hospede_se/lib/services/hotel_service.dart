import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:projeto_hospede_se/models/hotel.dart';
import 'package:projeto_hospede_se/models/hotel_manager.dart';
import 'package:flutter/material.dart';

class HotelsProvider extends ChangeNotifier {
  final _hotelsSnapshot = <DocumentSnapshot>[];

  String _search = '';
  String get search => _search;

  final bool _isSearchkey = true;
  bool get isSearchkey => _isSearchkey;

  String _errorMessage = '';
  String get errorMessage => _errorMessage;

  bool _hasNext = true;
  bool get hasNext => _hasNext;

  bool _isFetchingHotels = false;

  int documentLimit = 15;

  set search(String value) {
    _search = value;
    notifyListeners();
  }

  List<Hotel> getHotels() {
    List<Hotel> hotels = _hotelsSnapshot.map((snap) => Hotel.fromDocument(snap)).toList();
    List<Hotel> filteredhotels = [];
    filteredhotels.addAll(hotels.where((h) => h.name!.toLowerCase().contains(search.toLowerCase())));
    return filteredhotels;
  }

  Future fetchNextHotels() async {
    if (_isFetchingHotels) return;

    _errorMessage = '';
    _isFetchingHotels = true;

    try {
      final snap = await HotelManager.getFilteredHotels(
        documentLimit,
        search,
        1,
        startAfter: _hotelsSnapshot.isNotEmpty ? _hotelsSnapshot.last : null,
      );

      _hotelsSnapshot.addAll(snap.docs);

      if (getHotels().length < documentLimit) _hasNext = false;
      notifyListeners();
    } catch (error) {
      _errorMessage = error.toString();
      notifyListeners();
    }

    _isFetchingHotels = false;
  }
}
