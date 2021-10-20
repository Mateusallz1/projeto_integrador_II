import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:projeto_hospede_se/models/hotel.dart';

class SignUpException implements Exception {
  String message;
  SignUpException(this.message);
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
      throw SignUpException(e.message!);
    }
  }

  Future<void> loadHotel(UserId) async {
    String hotelId = '';
    await firestore.collection('hotel').where('user', isEqualTo: UserId).get().then((QuerySnapshot query) {
      for (var doc in query.docs) {
        hotelId = doc.id;
      }
    });
    DocumentSnapshot snapshotdoc = await FirebaseFirestore.instance.collection('hotel').doc(hotelId).get();
    _hotel = Hotel.fromDocument(snapshotdoc);
  }

  Hotel getHotel() {
    return _hotel!;
  }
}
