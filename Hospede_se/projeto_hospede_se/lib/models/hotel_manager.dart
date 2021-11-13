// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:projeto_hospede_se/models/hotel.dart';

class SignUpHotelException implements Exception {
  String message;
  SignUpHotelException(this.message);
}

class HotelManager extends ChangeNotifier {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Hotel? _hotel;

  Future<void> signUpHotel(Hotel _hotel) async {
    try {
      final hotelRef = FirebaseFirestore.instance.collection('hotel').doc();
      final hotelId = hotelRef.id;
      _hotel.id = hotelId;
      _hotel.saveData();
    } on FirebaseException catch (e) {
      throw SignUpHotelException(e.message!);
    }
  }

  Future<void> loadHotel(userId) async {
    String hotelId = '';
    await firestore.collection('hotel').where('user', isEqualTo: userId).get().then((QuerySnapshot query) {
      for (var doc in query.docs) {
        hotelId = doc.id;
      }
    });
    DocumentSnapshot snapshotdoc = await FirebaseFirestore.instance.collection('hotel').doc(hotelId).get();
    _hotel = Hotel.fromDocument(snapshotdoc);
  }

  static Future<QuerySnapshot> getFilteredHotels(int limit, String searchkey, int searchtype, {DocumentSnapshot? startAfter}) async {
    if (searchtype == 1 && searchkey.isNotEmpty) {
      final QuerySnapshot snapHotels;
      snapHotels = await FirebaseFirestore.instance.collection('hotel').where('name', arrayContains: searchkey).limit(limit).get();
      return snapHotels;
    } else {
      final QuerySnapshot snapHotels;
      snapHotels = await FirebaseFirestore.instance.collection('hotel').limit(limit).get();
      return snapHotels;
    }
  }

  Hotel getHotel() {
    return _hotel!;
  }

  void removeHotels() async {
    _hotel = null;
  }

  void removeHotel() async {
    _hotel = null;
  }
}
