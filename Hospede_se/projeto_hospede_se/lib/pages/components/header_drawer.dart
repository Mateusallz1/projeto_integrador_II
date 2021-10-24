import 'package:flutter/material.dart';
import 'package:projeto_hospede_se/models/hotel_manager.dart';
import 'package:projeto_hospede_se/services/auth_service.dart';
import 'package:projeto_hospede_se/widgets/auth_check.dart';
import 'package:provider/provider.dart';

class CustomDrawerHeader extends StatelessWidget {
  const CustomDrawerHeader({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    HotelManager hotelManager = context.read<HotelManager>();

    return Container(
      padding: const EdgeInsets.fromLTRB(32, 24, 16, 8),
      height: 180,
      child: Consumer<AuthService>(
        builder: (_, auth, __) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Text(
                '${hotelManager.getHotel().name}',
                style: const TextStyle(
                  fontSize: 34,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Olá, ${auth.getUser().name}',
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              GestureDetector(
                onTap: () {
                  if (auth.isLogged()) {
                    auth.signOut();
                    hotelManager.removeHotel();
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const AuthCheck()),
                    );
                  } else {
                    MaterialPageRoute(builder: (context) => const AuthCheck());
                  }
                },
                child: Container(
                  margin: const EdgeInsets.only(bottom: 30),
                  child: Text(
                    'Sair',
                    style: TextStyle(
                      color: Colors.green.shade800,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
