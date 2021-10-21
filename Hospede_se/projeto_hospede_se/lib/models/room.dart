import 'package:cloud_firestore/cloud_firestore.dart';

class Room {
  String? id;
  String? hotelId;
  int? number;
  int? quantity;
  String? title;
  String? description;
  bool? status;
  num? price;
  int? guestCount;
  int? bedCount;
  int? bathCount;
  //List<String>? images;

  Room.fromDocument(DocumentSnapshot document) {
    id = document.id;
    hotelId = document['hotel_id'] as String;
    number = document['number'] as int;
    quantity = document['quantity'] as int;
    title = document['title'] as String;
    description = document['description'] as String;
    status = document['status'] as bool;
    price = document['price'] as num;
    guestCount = document['guest_count'] as int;
    bedCount = document['bed_count'] as int;
    bathCount = document['bath_count'] as int;
    //images = List<String>.from(document['images'] as List<dynamic>);
  }

  DocumentReference get firestoreRef => FirebaseFirestore.instance.doc('rooms/$id');

  void saveData() async {
    await firestoreRef.set(toMap());
  }

  Map<String, dynamic> toMap() {
    return {
      'hotel_id': hotelId,
      'number': number,
      'quantity': quantity,
      'title': title,
      'description': description,
      'status': status,
      'price': price,
      'guest_count': guestCount,
      'bed_count': bedCount,
      'bath_count': bathCount,
      //'images' : List<String>.from(document['images'] as List<dynamic>);
    };
  }
}
