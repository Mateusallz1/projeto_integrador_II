import 'package:cloud_firestore/cloud_firestore.dart';

class UserApp {
  String? id;
  bool? host;
  String? name;
  String? email;
  String? password;
  String? confirmPassword;

  UserApp(
      {required this.host,
      required this.name,
      required this.email,
      required this.password,
      required this.confirmPassword});

  UserApp.fromDocument(DocumentSnapshot document) {
    id = document.id;
    name = document['name'];
    email = document['email'];
    host = document['host'];
  }

  DocumentReference get firestoreRef => FirebaseFirestore.instance.doc('users/$id');

  void saveData() async {
    await firestoreRef.set(toMap());
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'host': host,
    };
  }
}

class UserLogin {
  String email;
  String password;

  UserLogin({required this.email, required this.password});
}
