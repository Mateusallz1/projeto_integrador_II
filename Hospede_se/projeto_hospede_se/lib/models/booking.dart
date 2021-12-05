import 'package:cloud_firestore/cloud_firestore.dart';

class Booking {
  String? id;
  String? userId;
  String? roomId;
  String? roomName;
  DateTime? startdate;
  DateTime? enddate;
  int? quantity;
  String? bookingtype;
  num? roomPrice;
  num? bookingPrice;

  Booking({
    required this.userId,
    required this.startdate,
    required this.enddate,
    required this.quantity,
    required this.bookingtype,
  });

  Booking.fromDocument(DocumentSnapshot document) {
    id = document.id;
    userId = document['userId'] as String;
    roomId = document['roomId'] as String;
    roomName = document['roomName'] as String;
    startdate = (document['startdate'] as Timestamp).toDate();
    enddate = (document['enddate'] as Timestamp).toDate();
    quantity = document['quantity'] as int;
    roomPrice = document['roomPrice'] as num;
    bookingPrice = document['bookingPrice'] as num;
    bookingtype = document['bookingtype'] as String;
  }

  DocumentReference get firestoreRef => FirebaseFirestore.instance.doc('booking/$id');

  void saveData() async {
    await firestoreRef.set(toMap());
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'roomId': roomId,
      'roomName': roomName,
      'startdate': startdate,
      'enddate': enddate,
      'quantity': quantity,
      'roomPrice': roomPrice,
      'bookingPrice': bookingPrice,
      'bookingtype': bookingtype
    };
  }
}
