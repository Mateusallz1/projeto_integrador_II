import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:projeto_hospede_se/helpers/utils.dart';
import 'package:projeto_hospede_se/models/room.dart';

class SignUpRoomException implements Exception {
  String message;
  SignUpRoomException(this.message);
}

class RoomManager extends ChangeNotifier {
  List<Room> allRooms = [];
  List<Room> hotelRooms = [];
  static List<String> unavaibleRooms = [];
  static List<dynamic> bookingDateIntersection = [];
  static final idRoomsIntersection = <String>[];

  String _search = '';

  String get search => _search;
  set search(String value) {
    _search = value;
    notifyListeners();
  }

  List<Room> get filteredRooms {
    final List<Room> filteredRooms = [];

    if (search.isEmpty) {
      filteredRooms.addAll(hotelRooms);
    } else {
      filteredRooms.addAll(hotelRooms.where((p) => p.title!.toLowerCase().contains(search.toLowerCase())));
    }
    return filteredRooms;
  }

  Future<void> signUpRoom(Room _room, List<File> images) async {
    try {
      final roomRef = FirebaseFirestore.instance.collection('room').doc();
      final roomId = roomRef.id;
      _room.id = roomId;
      _room.storageImages(images);
      _room.saveData();
    } on FirebaseException catch (e) {
      throw SignUpRoomException(e.message!);
    }
  }

  static Future<void> getUnavaibleRooms(Map booking) async {
    idRoomsIntersection.clear();

    DateTime appstartdate = booking['startdate'];
    DateTime appenddate = booking['enddate'];

    bookingDateIntersection = await dateIntersections(appstartdate, appenddate);
    print('BOOKING 1 >>>>>>>>>>>>>>>> ' + bookingDateIntersection.toString());

    for (String element in bookingDateIntersection) {
      DocumentSnapshot doc = await firestore.collection('booking').doc(element).get();
      String roomId = await doc['roomId'];
      idRoomsIntersection.add(roomId);
      print('idRoomsIntersection 2 >>>>>>>>>>>>>>>> ' + idRoomsIntersection.toString());
    }

    unavaibleRooms = await getListUnavaibleRooms(idRoomsIntersection);
    print('unavaibleRooms 3 >>>>>>>>>>>>>>>> ' + unavaibleRooms.toString());
  }

  static Future<bool> hotelHaveRoomsBooking(String hotelId, Map booking) async {
    QuerySnapshot snapHotels = await firestore
        .collection('rooms')
        .where('hotel_id', isEqualTo: hotelId)
        .where('status', isEqualTo: true)
        .where('guest_count', isEqualTo: booking['quantity'])
        .get();

    if (snapHotels.size == 0) {
      return false;
    }
    return true;
  }

  Future<void> loadRooms(hotelId) async {
    final QuerySnapshot snapshotdocs =
        await firestore.collection('rooms').where('hotel_id', isEqualTo: hotelId).get();
    hotelRooms = snapshotdocs.docs.map((r) => Room.fromDocument(r)).toList();

    for (Room r in hotelRooms) {
      unavaibleRooms.contains(r.id.toString()) ? hotelRooms.remove(r) : null;
    }

    notifyListeners();
  }

  Future<void> update(Room room) async {
    hotelRooms.removeWhere((e) => e.id == room.id);
    hotelRooms.add(room);
    notifyListeners();
  }
}
