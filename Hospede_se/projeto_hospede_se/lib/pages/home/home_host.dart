import 'package:flutter/material.dart';
import 'package:projeto_hospede_se/models/hotel_manager.dart';
import 'package:projeto_hospede_se/pages/home/page_manager.dart';
import 'package:projeto_hospede_se/pages/rooms/room_manager.dart';
import 'package:projeto_hospede_se/pages/rooms/rooms_page.dart';
import 'package:projeto_hospede_se/services/auth_service.dart';
import 'package:projeto_hospede_se/widgets/drawer.dart';
import 'package:provider/provider.dart';

class HomeHostPage extends StatefulWidget {
  const HomeHostPage({Key? key}) : super(key: key);

  @override
  State<HomeHostPage> createState() => _HomeHostPageState();
}

class _HomeHostPageState extends State<HomeHostPage> {
  final GlobalKey<ScaffoldState> scaffoldKeyRooms = GlobalKey<ScaffoldState>();
  final PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    //AuthService authService = context.read<AuthService>();
    //HotelManager hotelManager = context.read<HotelManager>();
    //RoomManager roomManager = context.read<RoomManager>();
    String userId = context.read<AuthService>().getUser().id.toString();
    context.read<HotelManager>().loadHotel(userId);
    context.read<RoomManager>().loadRooms(context.read<HotelManager>().loadHotel(userId));
    return Provider(
      create: (_) => PageManager(pageController),
      child: PageView(
        controller: pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          Scaffold(
            backgroundColor: Colors.green.shade100,
            drawer: const CustomDrawer(),
            appBar: AppBar(
              backgroundColor: Colors.green.shade800,
              title: const Text('Início'),
            ),
          ),
          const RoomsPage(),
          Scaffold(
            backgroundColor: Colors.green.shade100,
            drawer: const CustomDrawer(),
            appBar: AppBar(
              backgroundColor: Colors.green.shade800,
              title: const Text('Estadias'),
            ),
          ),
        ],
      ),
    );
  }
}
