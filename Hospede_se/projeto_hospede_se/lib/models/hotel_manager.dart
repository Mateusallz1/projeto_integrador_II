import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:projeto_hospede_se/models/hotel.dart';

class HotelManager extends ChangeNotifier {
  Hotel? _hotel;

  Future<void> signUpHotel(Hotel _hotel) async {
    try {
      final hotelRef = FirebaseFirestore.instance.collection('hotel').doc();
      final hotelId = hotelRef.id;
      _hotel.id = hotelId;
      _hotel.saveData();
    } on FirebaseException catch (e) {
      //
    }
  }

  Future<void> loadHotel() async {}
}
