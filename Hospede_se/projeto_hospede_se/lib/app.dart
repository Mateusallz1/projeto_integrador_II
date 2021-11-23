import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:projeto_hospede_se/models/room.dart';
import 'package:projeto_hospede_se/pages/rooms/room_detail.dart';
import 'package:projeto_hospede_se/widgets/auth_check.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hospede se',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.green),
      home: const AuthCheck(),
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/room':
            return MaterialPageRoute(builder: (_) => RoomScreen(settings.arguments as Room));
        }
      },
    );
  }
}
