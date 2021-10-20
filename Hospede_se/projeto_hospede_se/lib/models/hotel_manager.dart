// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:projeto_hospede_se/models/hotel.dart';
import 'package:projeto_hospede_se/services/auth_service.dart';

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
      //
    }
  }

  Future<void> loadHotel(UserId) async {
    String hotelId = '';
    await firestore.collection('hotel').where('user', isEqualTo: UserId).get().then((QuerySnapshot query) {
      query.docs.forEach((doc) {
        hotelId = doc.id;
      });
    });

    print(hotelId);

    DocumentSnapshot snapshotdoc = await FirebaseFirestore.instance.collection('hotel').doc(hotelId).get();
    print(snapshotdoc.data().toString());
    _hotel = Hotel.fromDocument(snapshotdoc);
  }

  Hotel getHotel() {
    return _hotel!;
  }
}
