import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:projeto_hospede_se/models/booking.dart';

FirebaseFirestore firestore = FirebaseFirestore.instance;

List<dynamic> addIntersectionList(List<String> l1, List<String> l2) {
  final lists = [l1, l2];
  final result = lists.fold<Set>(lists.first.toSet(), (a, b) => a.intersection(b.toSet()));
  List<dynamic> resultList = [];
  resultList.addAll(result);
  return resultList;
}

List<String> listIdFromBooking(QuerySnapshot<Object?> querySnapshot) {
  List<String> ids = [];

  final documentSnapshot = <DocumentSnapshot>[];
  documentSnapshot.addAll(querySnapshot.docs);
  List<Booking> listObjects = documentSnapshot.map((b) => Booking.fromDocument(b)).toList();

  listObjects.forEach((b) {
    ids.add(b.id.toString());
  });

  return ids;
}

Future<List<dynamic>> dateIntersections(DateTime appstartdate, DateTime appenddate) async {
  //INSIDE BOOKING RANGE
  QuerySnapshot snapGetStartDate1 =
      await firestore.collection('booking').where('startdate', isLessThanOrEqualTo: appstartdate).get();
  List<String> l1 = listIdFromBooking(snapGetStartDate1);

  QuerySnapshot snapGetStartDate2 =
      await firestore.collection('booking').where('enddate', isGreaterThanOrEqualTo: appstartdate).get();
  List<String> l2 = listIdFromBooking(snapGetStartDate2);

  List<dynamic> l5 = addIntersectionList(l1, l2);

  QuerySnapshot snapGetEndDate1 =
      await firestore.collection('booking').where('startdate', isLessThanOrEqualTo: appenddate).get(); //L3
  List<String> l3 = listIdFromBooking(snapGetEndDate1);

  QuerySnapshot snapGetEndDate2 = //LISTA6
      await firestore.collection('booking').where('enddate', isGreaterThanOrEqualTo: appenddate).get(); //L4
  List<String> l4 = listIdFromBooking(snapGetEndDate2);

  List<dynamic> l6 = addIntersectionList(l3, l4);

  List<dynamic> l7 = l5 + l6;
  l7 = l7.toSet().toList();
  //

  //OUT OF RANGE
  QuerySnapshot snapGetStartDate3 = //LISTA8
      await firestore.collection('booking').where('startdate', isGreaterThan: appstartdate).get();
  List<String> l8 = listIdFromBooking(snapGetStartDate3);

  QuerySnapshot snapGetEndDate3 = //LISTA9
      await firestore.collection('booking').where('enddate', isLessThan: appenddate).get();
  List<String> l9 = listIdFromBooking(snapGetEndDate3);

  List<dynamic> l10 = addIntersectionList(l8, l9);

  List<dynamic> l11 = l7 + l10;
  return l11;
}

Future<List<String>> getListUnavaibleRooms(List<String> list) async {
  late List<String> roomsIds = [];
  Map map = {};
  list.forEach((r) {
    !map.containsKey(r) ? map[r] = 1 : map[r] += 1;
  });

  for (String key in map.keys) {
    DocumentSnapshot doc = await firestore.collection('rooms').doc(key.toString()).get();
    int quantity = doc['quantity'];
    quantity == map[key] ? roomsIds.add(key.toString()) : null;
  }
  return roomsIds;
}

int daysBetween(DateTime from, DateTime to) {
  from = DateTime(from.year, from.month, from.day);
  to = DateTime(to.year, to.month, to.day);
  return (to.difference(from).inHours / 24).round();
}
