import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:projeto_hospede_se/models/room.dart';

class SignUpRoomException implements Exception {
  String message;
  SignUpRoomException(this.message);
}

class RoomManager extends ChangeNotifier {
  RoomManager() {
    _loadAllRooms();
  }

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  List<Room> allRooms = [];
  List<Room> hotelRooms = [];

  Future<void> signUpRoom(Room _room) async {
    try {
      final roomRef = FirebaseFirestore.instance.collection('room').doc();
      final roomId = roomRef.id;
      _room.id = roomId;
      _room.saveData();
    } on FirebaseException catch (e) {
      throw SignUpRoomException(e.message!);
    }
  }

  Future<void> _loadAllRooms() async {
    final QuerySnapshot snapRoom = await firestore.collection('rooms').get();
    allRooms = snapRoom.docs.map((d) => Room.fromDocument(d)).toList();

    notifyListeners();
  }

  Future<void> loadRooms(hotelId) async {
    final QuerySnapshot snapshotdocs = await firestore
        .collection('rooms')
        .where('hotel_id', isEqualTo: hotelId)
        .get();
    hotelRooms = snapshotdocs.docs.map((d) => Room.fromDocument(d)).toList();
    notifyListeners();
  }
}
