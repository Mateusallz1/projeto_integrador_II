import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:projeto_hospede_se/models/booking.dart';

class AddBookingException implements Exception {
  String message;
  AddBookingException(this.message);
}

class BookingManager extends ChangeNotifier {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  static late Booking _booking;

  Booking get booking => _booking;
  set booking(Booking value) {
    _booking = value;
    notifyListeners();
  }

  static Future<void> addBooking() async {
    try {
      final bookingRef = FirebaseFirestore.instance.collection('booking').doc();
      final bookingId = bookingRef.id;
      _booking.id = bookingId;
      _booking.saveData();
    } on FirebaseException catch (e) {
      throw AddBookingException(e.message!);
    }
  }
}
