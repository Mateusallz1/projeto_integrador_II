import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:projeto_hospede_se/app.dart';
import 'package:projeto_hospede_se/models/hotel_manager.dart';
import 'package:projeto_hospede_se/models/room_manager.dart';
import 'package:projeto_hospede_se/services/auth_service.dart';
import 'package:projeto_hospede_se/services/hotel_service.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AuthService(),
          lazy: false,
        ),
        ChangeNotifierProvider(
          create: (context) => HotelManager(),
          lazy: false,
        ),
        ChangeNotifierProvider(
          create: (context) => RoomManager(),
          lazy: false,
        ),
        ChangeNotifierProvider(
          create: (context) => HotelsProvider(),
          lazy: false,
        ),
      ],
      child: const App(),
    ),
  );
}
