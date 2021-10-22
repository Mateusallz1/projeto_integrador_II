import 'package:flutter/material.dart';
import 'package:projeto_hospede_se/pages/home/home_host.dart';
import 'package:projeto_hospede_se/pages/welcome/welcome.dart';
import 'package:projeto_hospede_se/services/auth_service.dart';
import 'package:provider/provider.dart';

class AuthCheck extends StatefulWidget {
  const AuthCheck({Key? key}) : super(key: key);

  @override
  _AuthCheckState createState() => _AuthCheckState();
}

class _AuthCheckState extends State<AuthCheck> {
  @override
  Widget build(BuildContext context) {
    AuthService auth = Provider.of<AuthService>(context);

    if (auth.isLoading) {
      return loading();
    } else if (!auth.isLogged()) {
      return const WelcomePage();
    } else {
      // AuthService authService = context.read<AuthService>();
      // HotelManager hotelManager = context.read<HotelManager>();
      // RoomManager roomManager = context.read<RoomManager>();
      // hotelManager.loadHotel(authService.getUser().id.toString());
      // roomManager.loadRooms(hotelManager.getHotel().id);
      return const HomeHostPage();
    }
  }

  loading() {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
