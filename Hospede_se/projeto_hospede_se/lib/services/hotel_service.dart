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

  List<Hotel> get hotels => _hotelsSnapshot.map((snap) {
        // OPÇÃO 1
        //   return Hotel(userId: snap['user'] as String, name: snap['name'] as String, phone: snap['phone'] as String, address: snap['address'] as String, number: snap['number'] as String, city: snap['city'] as String, state: snap['state'] as String, country: snap['country'] as String, rating: snap['rating'] as int);
        // }).toList();
        //
        // OPÇÃO 2
        final Hotel hotel = Hotel.fromDocument(snap);
        return hotel;
      }).toList();
  Future fetchNextHotels() async {
    if (_isFetchingHotels) return;

    _errorMessage = '';
    _isFetchingHotels = true;

    try {
      final snap = await HotelManager.loadAllHotels2(
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
