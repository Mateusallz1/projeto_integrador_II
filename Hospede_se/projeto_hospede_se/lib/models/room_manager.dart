import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:projeto_hospede_se/models/room.dart';

class SignUpRoomException implements Exception {
  String message;
  SignUpRoomException(this.message);
}

class RoomManager extends ChangeNotifier {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  List<Room> allRooms = [];
  List<Room> hotelRooms = [];

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
      filteredRooms.addAll(hotelRooms
          .where((p) => p.title!.toLowerCase().contains(search.toLowerCase())));
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

  Future<void> loadRooms(hotelId) async {
    //
    final QuerySnapshot snapshotdocs = await firestore
        .collection('rooms')
        .where('hotel_id', isEqualTo: hotelId)
        .get();
    hotelRooms = snapshotdocs.docs.map((d) => Room.fromDocument(d)).toList();
    notifyListeners();
  }

  Future<void> update(Room room) async {
    hotelRooms.removeWhere((e) => e.id == room.id);
    hotelRooms.add(room);
    notifyListeners();
  }
}
