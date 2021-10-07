import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class UserApp {
  String id;
  String name;
  String email;
  String password;
  String confirmPassword;

  UserApp(
      {required this.id,
      required this.name,
      required this.email,
      required this.password,
      required this.confirmPassword});

  DocumentReference get firestoreRef =>
      FirebaseFirestore.instance.doc('users/$id');

  Future<void> saveData() async {
    await firestoreRef.set(toMap());
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
    };
  }
}

class UserLogin {
  String email;
  String password;

  UserLogin({required this.email, required this.password});
}
