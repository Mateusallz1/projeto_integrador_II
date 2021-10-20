// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:projeto_hospede_se/helpers/firebase_errors.dart';
import 'package:projeto_hospede_se/models/user.dart';
import 'package:flutter/material.dart';

class AuthException implements Exception {
  String message;
  AuthException(this.message);
}

class AuthService extends ChangeNotifier {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  UserApp? _user;
  bool isLoading = true;

  AuthService() {
    authcheck();
  }

  void authcheck() {
    auth.authStateChanges().listen((User? user) {
      user = (user == null) ? null : user;
      setLoading(false);
      notifyListeners();
    });
  }

  bool isLogged() {
    if (_user != null) {
      return true;
    }
    return false;
  }

  Future<void> signUp(UserApp _user) async {
    try {
      UserCredential usercredential = await auth.createUserWithEmailAndPassword(email: _user.email!, password: _user.confirmPassword!);
      _user.id = usercredential.user!.uid;
      _user.saveData();
      await loadCurrentUser();
    } on FirebaseAuthException catch (e) {
      throw AuthException(getErrorString(e.code));
    }
  }

  Future<void> signIn(UserLogin _user) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: _user.email, password: _user.password);
      await loadCurrentUser();
    } on FirebaseAuthException catch (e) {
      throw AuthException(getErrorString(e.code));
    }
  }

  Future<void> loadCurrentUser() async {
    final User? currentUser = auth.currentUser;
    if (currentUser != null) {
      DocumentSnapshot snapshotdoc = await FirebaseFirestore.instance.collection('users').doc(currentUser.uid).get();
      _user = UserApp.fromDocument(snapshotdoc);
      print(_user!.id);
      print(_user!.name);
      print(_user!.email);
      notifyListeners();
    }
  }

  UserApp getUser() {
    return _user!;
  }

  void signOut() async {
    await auth.signOut();
    _user = null;
  }

  void setLoading(bool value) {
    isLoading = value;
  }
}
