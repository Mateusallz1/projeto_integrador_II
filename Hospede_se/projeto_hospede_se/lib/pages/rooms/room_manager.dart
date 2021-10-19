import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:projeto_hospede_se/models/room.dart';

class RoomManager extends ChangeNotifier {
  RoomManager() {
    _loadAllRooms();
  }

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  List<Room> _allRooms = [];

  Future<void> _loadAllRooms() async {
    // final QuerySnapshot snapRoom = await firestore.collection('rooms').get();

    // _allRooms = snapRoom.docs.map((d) => Room.fromDocument(d)).toList();

    final QuerySnapshot snapRoom = await firestore.collection('rooms').get();

    _allRooms = snapRoom.docs.map((d) => Room.fromDocument(d)).toList();

    notifyListeners();
  }
}
