import 'package:cloud_firestore/cloud_firestore.dart';


class Room {
  Room.fromDocument(DocumentSnapshot document){
    id = document.id;
    number = document['number'] as int;
    description = document['description'] as String;
    images = List<String>.from(document['images'] as List<dynamic>);
  }

  String? id;
  int? number;
  String? description;
  List<String>? images;
}