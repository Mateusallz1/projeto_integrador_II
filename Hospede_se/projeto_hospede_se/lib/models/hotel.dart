import 'dart:io';

import 'package:uuid/uuid.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

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
  List<String> images = [];

  Hotel(
      {required this.userId,
      required this.name,
      required this.phone,
      required this.address,
      required this.number,
      required this.city,
      required this.state,
      required this.country,
      required this.rating,
      required this.images});

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
    if (document['images'] is List) {
      for (var i = 0; i < document['images'].length; i++) {
        images.add(document['images'][i] as String);
      }
    } else {
      images.add(document['images'] as String);
    }
  }

  DocumentReference get firestoreRef =>
      FirebaseFirestore.instance.doc('hotel/$id');

  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  void saveData() async {
    await firestoreRef.set(toMap());
  }

  final List<String> updateImages = [];

  Future<void> storageImages(List<File> newImages) async {
    firebase_storage.Reference storagerefence = firebase_storage
        .FirebaseStorage.instance
        .ref()
        .child('hotels')
        .child(id!);

    for (var i = 0; i < newImages.length; i++) {
      File file = newImages[i];
      if (images.contains(file.path)) {
        updateImages.add(file.path);
      } else {
        final firebase_storage.Reference reference =
            storagerefence.child(const Uuid().v1());
        final firebase_storage.TaskSnapshot snapshot =
            await reference.putFile(file);
        final String url = await snapshot.ref.getDownloadURL();
        updateImages.add(url);
      }
    }
    await firestoreRef.update({'images': updateImages});
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
      'images': images,
    };
  }
}
