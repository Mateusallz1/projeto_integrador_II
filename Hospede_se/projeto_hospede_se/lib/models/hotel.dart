import 'package:cloud_firestore/cloud_firestore.dart';

class Hotel {
  String? id;
  String? userId;
  String? name;
  String? phone;
  String? address;
  String? city;
  String? state;
  String? country;
  int? rating;
  //List<String>? images;

  Hotel({required userId, required name, required address, required city, required state, required country, required rating});

  Hotel.fromDocument(DocumentSnapshot document) {
    id = document.id;
    name = document['name'] as String;
    userId = document['userId'] as String;
    phone = document['fone'] as String;
    address = document['adress'] as String;
    city = document['city'] as String;
    state = document['state'] as String;
    country = document['country'] as String;
    rating = document['rating'] as int;
    //images = List<String>.from(document['images'] as List<dynamic>);
  }

  DocumentReference get firestoreRef => FirebaseFirestore.instance.doc('hotel/$id');

  void saveData() async {
    await firestoreRef.set(toMap());
  }

  Map<String, dynamic> toMap() {
    return {
      'user': userId,
      'name': name,
      'phone': phone,
      'address': address,
      'city': city,
      'state': state,
      'country': country,
      'rating': rating,
      //'images' : List<String>.from(document['images'] as List<dynamic>);
    };
  }
}
