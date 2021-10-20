import 'package:cloud_firestore/cloud_firestore.dart';

class Hotel {
  String? id;
  String? address;
  String? city;
  String? country;
  String? name;
  String? number;
  String? phone;
  int? rating;
  String? state;
  String? userId;
  //List<String>? images;

  Hotel({required this.userId, required this.name, required this.phone, required this.address, required this.number, required this.city, required this.state, required this.country, required this.rating});

  Hotel.fromDocument(DocumentSnapshot document) {
    id = document.id;
    address = document['address'];
    city = document['city'];
    country = document['country'];
    name = document['name'];
    number = document['number'];
    phone = document['phone'];
    rating = document['rating'];
    state = document['state'];
    userId = document['user'];
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
      'number': number,
      'city': city,
      'state': state,
      'country': country,
      'rating': rating,
      //'images' : List<String>.from(document['images'] as List<dynamic>);
    };
  }
}
