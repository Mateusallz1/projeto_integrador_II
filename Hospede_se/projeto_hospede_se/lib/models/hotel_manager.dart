import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:projeto_hospede_se/models/user.dart';
import 'package:projeto_hospede_se/services/auth_service.dart';

class HotelManager extends ChangeNotifier {
  UserApp? user;

  void updateUser(AuthService authService) {
    user = authService.getUser();
  }
}
