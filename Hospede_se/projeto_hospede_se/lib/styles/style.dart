import 'package:flutter/material.dart';

var titleText = TextStyle(
  fontSize: 30,
  fontWeight: FontWeight.normal,
);

var descText = TextStyle(
  fontSize: 15,
  color: Colors.grey,
  fontWeight: FontWeight.normal,
);

var elevatedButton = ElevatedButton.styleFrom(
  primary: Colors.green,
  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
  shape: StadiumBorder(),
);

var inputBorderGreen = UnderlineInputBorder(
  borderSide: BorderSide(color: Colors.green),
);

var inputFocusedBorderGreen = UnderlineInputBorder(
  borderSide: BorderSide(color: Colors.green),
);
