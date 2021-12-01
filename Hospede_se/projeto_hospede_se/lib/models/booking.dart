import 'package:cloud_firestore/cloud_firestore.dart';

class Booking {
  String? id;
  String? userId;
  String? roomId;
  DateTime? startdate;
  DateTime? enddate;
  int? quantity;
  //Enum? bookingtype;

  Booking({
    required this.userId,
    required this.startdate,
    required this.enddate,
    required this.quantity,
    //required this.bookingtype,
  });

  Booking.fromDocument(DocumentSnapshot document) {
    id = document.id;
    userId = document['userId'] as String;
    roomId = document['roomId'] as String;
    startdate = document['startdate'] as DateTime;
    enddate = document['enddate'] as DateTime;
    quantity = document['quantity'] as int;
    //bookingtype = document['bookingtype'] as Enum;
  }

  DocumentReference get firestoreRef => FirebaseFirestore.instance.doc('booking/$id');

  void saveData() async {
    print('sdaodaisjdaiodjaioaoisdjadnaioyudbgaiuydgastuygatdgatdgasydtasytd');
    await firestoreRef.set(toMap());
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'roomId': roomId,
      'startdate': startdate,
      'enddate': enddate,
      'quantity': quantity,
      //'booking': bookingtype
    };
  }
}
