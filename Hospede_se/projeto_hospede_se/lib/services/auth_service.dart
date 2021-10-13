import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:projeto_hospede_se/helpers/firebase_errors.dart';
import 'package:projeto_hospede_se/models/user.dart';
import 'package:flutter/material.dart';

class AuthException implements Exception {
  String message;
  AuthException(this.message);
}

class AuthService extends ChangeNotifier {
  FirebaseAuth auth = FirebaseAuth.instance;
  User? user;
  bool isLoading = true;

  AuthService() {
    authcheck();
  }

  void authcheck() {
    auth.authStateChanges().listen((User? user) {
      user = (user == null) ? null : user;
      setLoading(false);
      notifyListeners();
      }
    );
  }

  void getUser() {
    user = auth.currentUser;
    notifyListeners();
  }

  Future<void> signUp(UserApp _user) async {
    try {
      UserCredential usercredential = await auth.createUserWithEmailAndPassword(email: _user.email, password: _user.confirmPassword);
      _user.id = usercredential.user!.uid;
      _user.saveData();
      getUser();
    } on FirebaseAuthException catch (e) {
      throw AuthException(getErrorString(e.code));
    }
  }

  Future<void> signIn(UserLogin _user) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: _user.email, password: _user.password);
      getUser();
    } on FirebaseAuthException catch (e) {
      throw AuthException(getErrorString(e.code));
    }
  }

  void signOut() async {
    await auth.signOut();
    getUser();
  }

  void setLoading(bool value) {
    isLoading = value;
  }
}
