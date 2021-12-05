import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:projeto_hospede_se/models/booking_manager.dart';
import 'package:projeto_hospede_se/models/hotel.dart';
import 'package:projeto_hospede_se/models/room_manager.dart';
import 'package:projeto_hospede_se/models/user.dart';
import 'package:projeto_hospede_se/services/auth_service.dart';
import 'package:projeto_hospede_se/ui/pages/components/booking_list_tile.dart';
import 'package:projeto_hospede_se/ui/pages/components/room_list_tile.dart';
import 'package:provider/provider.dart';

class BookedListView extends StatefulWidget {
  const BookedListView({Key? key}) : super(key: key);

  @override
  State<BookedListView> createState() => _BookedListViewState();
}

class _BookedListViewState extends State<BookedListView> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    String userId = context.read<AuthService>().getUser().id!;
    BookingManager.loadBookingList(userId);
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          child: SingleChildScrollView(
            child: Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: Consumer<BookingManager>(
                      builder: (_, bookingManager, __) {
                        return ListView.builder(
                          shrinkWrap: true,
                          itemCount: bookingManager.bookedlist.length,
                          itemBuilder: (_, index) {
                            return BookingListTile(bookingManager.bookedlist[index]);
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
