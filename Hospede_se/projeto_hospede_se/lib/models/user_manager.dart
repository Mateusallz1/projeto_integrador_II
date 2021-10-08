import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:projeto_hospede_se/helpers/firebase_errors.dart';
import 'package:projeto_hospede_se/models/user.dart';

final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

class UserManager extends ChangeNotifier {
  FirebaseAuth auth = FirebaseAuth.instance;
  bool isLoading = false;
  User? user;

  Future<void> signIn(UserLogin _user) async {
    setLoading(true);
    try {
      UserCredential usercredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: _user.email, password: _user.password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'ERROR-USER-NOT-FOUND') {
        //
      } else if (e.code == 'ERROR-WRONG-PASSWORD') {
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
      _user.id = usercredential.user!.uid;
      await _user.saveData();
      onSuccess();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'ERROR-WEAK-PASSWORD') {
        onFail(getErrorString(e.code));
      } else if (e.code == 'ERROR_EMAIL_ALREADY_IN_USE') {
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
