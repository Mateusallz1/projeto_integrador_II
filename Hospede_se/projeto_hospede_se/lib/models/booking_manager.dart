import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:projeto_hospede_se/helpers/utils.dart';
import 'package:projeto_hospede_se/models/booking.dart';
import 'package:projeto_hospede_se/models/booking_type.dart';

class AddBookingException implements Exception {
  String message;
  AddBookingException(this.message);
}

class BookingManager extends ChangeNotifier {
  static FirebaseFirestore firestore = FirebaseFirestore.instance;

  static late Booking _booking;

  static List<Booking> _bookedList = [];
  static List<Booking> _hostedList = [];
  static List<Booking> _inactiveList = [];

  List<Booking> get bookedlist => _bookedList;
  List<Booking> get hostedList => _hostedList;
  List<Booking> get inactiveList => _inactiveList;

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

  static Future<void> loadBookingList(String userId) async {
    final bookedSnapshot = <DocumentSnapshot>[];
    final hostedSnapshot = <DocumentSnapshot>[];
    final inactiveSnapshot = <DocumentSnapshot>[];

    try {
      QuerySnapshot querySnapshotBooked = await firestore
          .collection('booking')
          .where('userId', isEqualTo: userId)
          .where('bookingtype', isEqualTo: bookingType(0))
          .get();

      QuerySnapshot querySnapshotHosted = await firestore
          .collection('booking')
          .where('userId', isEqualTo: userId)
          .where('bookingtype', isEqualTo: bookingType(1))
          .get();

      QuerySnapshot querySnapshotInactive = await firestore
          .collection('booking')
          .where('userId', isEqualTo: userId)
          .where('bookingtype', isEqualTo: bookingType(2))
          .get();

      bookedSnapshot.addAll(querySnapshotBooked.docs);
      hostedSnapshot.addAll(querySnapshotHosted.docs);
      inactiveSnapshot.addAll(querySnapshotInactive.docs);

      _bookedList = bookedSnapshot.map((snap) => Booking.fromDocument(snap)).toList();
      _hostedList = hostedSnapshot.map((snap) => Booking.fromDocument(snap)).toList();
      _inactiveList = inactiveSnapshot.map((snap) => Booking.fromDocument(snap)).toList();
    } on FirebaseException catch (e) {
      throw AddBookingException(e.message!);
    }
  }
}
