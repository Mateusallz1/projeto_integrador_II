import 'package:flutter/material.dart';

var titleText = const TextStyle(
  fontSize: 30,
  fontWeight: FontWeight.normal,
);

var descText = const TextStyle(
  fontSize: 15,
  color: Colors.grey,
  fontWeight: FontWeight.normal,
);

var elevatedButton = ElevatedButton.styleFrom(
  primary: Colors.green,
  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
  shape: const StadiumBorder(),
);

var inputBorderGreen = const UnderlineInputBorder(
  borderSide: BorderSide(color: Colors.green),
);

var inputFocusedBorderGreen = const UnderlineInputBorder(
  borderSide: BorderSide(color: Colors.green),
);
