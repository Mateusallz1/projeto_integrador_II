import 'package:flutter/material.dart';

var titleTextBlack = const TextStyle(
  fontSize: 30,
  fontWeight: FontWeight.normal,
);

var titleText2Black = const TextStyle(
  color: Colors.black,
  fontWeight: FontWeight.bold,
  fontSize: 35,
);

var descTextGrey = const TextStyle(
  fontSize: 15,
  color: Colors.grey,
  fontWeight: FontWeight.normal,
);

var labelTextWhite = const TextStyle(
  fontSize: 15,
  color: Colors.white,
  fontWeight: FontWeight.normal,
);

var elevatedButton = ElevatedButton.styleFrom(
  primary: Colors.green.shade800,
  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
  shape: const StadiumBorder(),
);

var elevatedButtonConfirm = ElevatedButton.styleFrom(
  primary: Colors.green.shade800,
  padding: const EdgeInsets.symmetric(vertical: 12),
  textStyle: const TextStyle(
    fontSize: 20,
  ),
);

var inputBorderGreen = const UnderlineInputBorder(
  borderSide: BorderSide(color: Colors.green),
);

var inputFocusedBorderGreen = const UnderlineInputBorder(
  borderSide: BorderSide(color: Colors.green),
);

InputDecoration inputDecorationRadius(txt) {
  return InputDecoration(
    labelText: txt,
    labelStyle: const TextStyle(color: Colors.grey),
    focusedBorder: const OutlineInputBorder(
      borderSide: BorderSide(color: Colors.green),
      borderRadius: BorderRadius.all(
        Radius.circular(5),
      ),
    ),
    enabledBorder: const OutlineInputBorder(
      borderSide: BorderSide(color: Colors.green),
      borderRadius: BorderRadius.all(
        Radius.circular(5),
      ),
    ),
  );
}

InputDecoration inputDecorationSignUp(txt, icon) {
  return InputDecoration(
    labelText: txt,
    icon: icon,
    enabledBorder: inputBorderGreen,
    focusedBorder: inputFocusedBorderGreen,
  );
}
