import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:projeto_hospede_se/models/hotel.dart';
import 'package:projeto_hospede_se/models/hotel_manager.dart';
import 'package:flutter/material.dart';
import 'package:projeto_hospede_se/models/room_manager.dart';

class HotelsProvider extends ChangeNotifier {
  final _hotelsSnapshot = <DocumentSnapshot>[];

  String _search = '';
  String get search => _search;

  Map _booking = {};
  Map get booking => _booking;

  final bool _isSearchkey = true;
  bool get isSearchkey => _isSearchkey;

  String _errorMessage = '';
  String get errorMessage => _errorMessage;

  bool _hasNext = true;
  bool get hasNext => _hasNext;

  bool _isFetchingHotels = false;

  int documentLimit = 15;

  set booking(Map value) {
    _booking = value;
  }

  set search(String value) {
    _search = value;
    notifyListeners();
  }

  List<Hotel> getHotels() {
    List<Hotel> hotels = _hotelsSnapshot.map((snap) => Hotel.fromDocument(snap)).toList();
    List<Hotel> filteredhotels = [];
    filteredhotels.addAll(hotels.where((h) => h.name!.toLowerCase().contains(search.toLowerCase())));
    if (search.isNotEmpty) {
      final ids = filteredhotels.map((h) => h.id).toSet();
      filteredhotels.retainWhere((h) => ids.remove(h.id));
    }
    notifyListeners();
    return filteredhotels;
  }

  Future fetchNextHotels(int type) async {
    if (_isFetchingHotels) return;

    _errorMessage = '';
    _isFetchingHotels = true;

    try {
      if (type == 1) {
        final snap = await HotelManager.getFilteredHotels(
          documentLimit,
          search,
          1,
          startAfter: _hotelsSnapshot.isNotEmpty ? _hotelsSnapshot.last : null,
        );
        _hotelsSnapshot.clear();
        _hotelsSnapshot.addAll(snap.docs);
      } else if (type == 2) {
        _hotelsSnapshot.clear();
        final snap = await HotelManager.getBookingHotels(documentLimit, booking);
        _hotelsSnapshot.addAll(snap.docs);
        // ignore: avoid_function_literals_in_foreach_calls
        await RoomManager.getUnavaibleRooms(booking);
        _hotelsSnapshot.forEach((h) async {
          if (!await RoomManager.hotelHaveRoomsBooking(h.id, booking)) {
            _hotelsSnapshot.remove(h);
            notifyListeners();
          }
        });
      }

      if (_hotelsSnapshot.length < documentLimit) _hasNext = false;
      notifyListeners();
    } catch (error) {
      _errorMessage = error.toString();
      notifyListeners();
    }

    _isFetchingHotels = false;
  }
}
