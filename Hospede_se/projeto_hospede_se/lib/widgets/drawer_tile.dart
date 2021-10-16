import 'package:flutter/material.dart';

class DrawerTile extends StatelessWidget {
  DrawerTile({required this.icondata, required this.title});

  final IconData icondata;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icondata,
          size: 32,
          color: Colors.green,
        ),
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.green,
          ),
        ),
      ],
    );
  }
}
