import 'package:flutter/material.dart';
import 'package:projeto_hospede_se/models/booking_manager.dart';
import 'package:projeto_hospede_se/services/auth_service.dart';
import 'package:projeto_hospede_se/ui/pages/components/booked_list.dart';
import 'package:projeto_hospede_se/ui/pages/components/hosted_list.dart';
import 'package:projeto_hospede_se/ui/pages/components/inactive_list.dart';
import 'package:provider/src/provider.dart';

class NotificationsUserPage extends StatefulWidget {
  const NotificationsUserPage({Key? key}) : super(key: key);

  @override
  State<NotificationsUserPage> createState() => _NotificationsUserPage();
}

class _NotificationsUserPage extends State<NotificationsUserPage> {
  Future getFutureData() async {
    String userId = context.read<AuthService>().getUser().id!;
    await BookingManager.loadBookingList(userId);
  }

  @override
  Widget build(BuildContext context) {
    String userId = context.read<AuthService>().getUser().id!;
    BookingManager.loadBookingList(userId);
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green.shade800,
          title: const Text('Reservas'),
          bottom: TabBar(
            tabs: const [
              Tab(
                text: 'Reservado',
              ),
              Tab(
                text: 'Estadia',
              ),
              Tab(
                text: 'Histórico',
              ),
            ],
            indicatorColor: Colors.green.shade800,
          ),
        ),
        body: TabBarView(
          children: [
            Column(
              children: [BookedListView()],
            ),
            Column(
              children: [HostedListView()],
            ),
            Column(
              children: [InactiveListView()],
            ),
          ],
        ),
      ),
    );
  }
}
