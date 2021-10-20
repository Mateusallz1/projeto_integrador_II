import 'package:flutter/material.dart';
import 'package:projeto_hospede_se/models/room.dart';


class RoomListTile extends StatelessWidget {
  RoomListTile(this.room);

  final Room room;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4)
      ),
      child: Container(
        height: 100,
        padding: const EdgeInsets.all(8),
        child: Row(
          children: [
            AspectRatio(
              aspectRatio: 1,
              child: Image.network(room.images!.first),
            ),
            Expanded(
              child: Column(
                children: [
                  Text(
                    room.title!,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                    ),
                  )
                ],
              )
            )
          ],
        ),
      ),
    );
  }
}