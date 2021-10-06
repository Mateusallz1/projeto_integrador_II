import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:projeto_hospede_se/models/user.dart';

class UserManager extends ChangeNotifier {
  FirebaseAuth auth = FirebaseAuth.instance;
  bool isLoading = false;
  User? user;

  Future<void> signIn(UserApp _user) async {
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
    setLoading(false);
  }

  Future<void> signUp(UserApp _user) async {
    setLoading(true);
    try {
      UserCredential usercredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: _user.email, password: _user.password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        //
      } else if (e.code == 'email-already-in-use') {
        //
      }
    }
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
