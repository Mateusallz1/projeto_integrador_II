import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:projeto_hospede_se/helpers/firebase_errors.dart';
import 'package:projeto_hospede_se/models/user.dart';

final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

class UserManager extends ChangeNotifier {
  FirebaseAuth auth = FirebaseAuth.instance;
  bool isLoading = false;
  User? user;
  UserApp? localeUser;

  Future<void> signIn(UserLogin _user) async {
    setLoading(true);
    try {
      UserCredential usercredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: _user.email, password: _user.password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        //
      } else if (e.code == 'wrong-password') {
        //
      }
    }
  }

  Future<void> signUp(
      UserApp _user, Function onSuccess, Function onFail) async {
    setLoading(true);
    try {
      UserCredential usercredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: _user.email, password: _user.password);
      localeUser!.id = usercredential.user!.uid;
      await localeUser!.saveData();
      onSuccess();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        onFail(getErrorString(e.code));
      } else if (e.code == 'email-already-in-use') {
        onFail(getErrorString(e.code));
      }
    }
    setLoading(false);
  }

  getUser() {
    user = auth.currentUser;
    notifyListeners();
  }

  void signOut() async {
    await auth.signOut();
  }

  void setLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }
}
