import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:projeto_hospede_se/models/hotel_manager.dart';
import 'package:projeto_hospede_se/models/room_manager.dart';
import 'package:projeto_hospede_se/ui/pages/components/drawer.dart';
import 'package:provider/src/provider.dart';

class StartPage extends StatefulWidget {
  const StartPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _StartPageState();
   
}

class _StartPageState extends State<StartPage>{
  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldKeyAbode = GlobalKey<ScaffoldState>();
    final PageController pageController = PageController();

    HotelManager hotelManager = context.read<HotelManager>();
    RoomManager roomManager = context.read<RoomManager>();

    return Scaffold(
      key: scaffoldKeyAbode,
      backgroundColor: Colors.green.shade100,
      drawer: const CustomDrawer(),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.green.shade800,
        title: Text('${hotelManager.getHotel().name}'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Image.network(hotelManager.getHotel().images.first),
                Positioned(
                bottom: 0,
                
                child: Text(
                  '${hotelManager.getHotel().address}',
                  style: TextStyle(
                    backgroundColor: Colors.green.shade800,
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.bold
                    ),
                  ),
                )
              ]
            ),        
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('${hotelManager.getHotel().number}',
                    style: const TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold
                      ),
                    ),
                  ],
                ),
                /*Card(
                  child: Text('Quartos ${roomManager.hotelRooms.length.toString()}'),
                ) */
              ],
            )
          ],
        ),
      ),
    );
  }
  
}