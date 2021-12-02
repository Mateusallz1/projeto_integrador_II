import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:uuid/uuid.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class Room extends ChangeNotifier {
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
  List<String> images = [];

  List<dynamic>? newImages;

  bool _loading = false;
  bool get loading => _loading;
  set loading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Room(
      {required this.hotelId,
      required this.number,
      required this.quantity,
      required this.title,
      required this.description,
      required this.status,
      required this.price,
      required this.guestCount,
      required this.bedCount,
      required this.bathCount,
      required this.images});

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
    if (document['images'] is List) {
      for (var i = 0; i < document['images'].length; i++) {
        images.add(document['images'][i] as String);
      }
    } else {
      images.add(document['images'] as String);
    }
  }

  DocumentReference get firestoreRef =>
      FirebaseFirestore.instance.doc('rooms/$id');

  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  void saveData() async {
    await firestoreRef.set(toMap());
  }

  Future<void> updateRoom() async {
    loading = true;

    final Map<String, dynamic> data = {
      'title': title,
      'description': description,
      'number': number,
      'guest_count': guestCount,
      'bed_count': bedCount,
      'bath_count': bathCount,
    };
    firestoreRef.update(data);
    storageUpdateImages();
    loading = false;
    notifyListeners();
  }

  final List<String> updateImages = [];

  Future<void> storageUpdateImages() async {
    firebase_storage.Reference storagerefence = firebase_storage
        .FirebaseStorage.instance
        .ref()
        .child('rooms')
        .child(id!);

    for (final newImage in newImages!) {
      if (images.contains(newImage)) {
        updateImages.add(newImage as String);
      } else {
        firebase_storage.Reference reference =
            storagerefence.child(const Uuid().v1());
        firebase_storage.TaskSnapshot snapshot =
            await reference.putFile(newImage as File);
        final String url = await snapshot.ref.getDownloadURL();
        updateImages.add(url);
      }
    }

    for (final image in images) {
      if (!newImages!.contains(image)) {
        // ignore: await_only_futures
        final ref = await storage.refFromURL(image);
        await ref.delete();
      }
    }

    await firestoreRef.update({'images': updateImages});

    images = updateImages;
  }

  Future<void> storageImages(List<File> newImages) async {
    firebase_storage.Reference storagerefence = firebase_storage
        .FirebaseStorage.instance
        .ref()
        .child('rooms')
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

  Room clone() {
    return Room(
        bathCount: bathCount,
        bedCount: bedCount,
        description: description,
        guestCount: guestCount,
        hotelId: hotelId,
        images: List.from(images),
        number: number,
        price: price,
        quantity: quantity,
        status: status,
        title: title);
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
      'images': images,
    };
  }
}
