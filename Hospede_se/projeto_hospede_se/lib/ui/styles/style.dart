import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
);

var elevatedButtonConfirm = ElevatedButton.styleFrom(
  primary: Colors.green.shade800,
  //padding: const EdgeInsets.symmetric(vertical: 5),
  textStyle: const TextStyle(
    fontSize: 20,
  ),
);

var elevatedButtonConfirmWhite = ElevatedButton.styleFrom(
  primary: Colors.white,
  padding: const EdgeInsets.symmetric(vertical: 12),
  textStyle: const TextStyle(fontSize: 20),
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

InputDecoration inputDecorationRadiusWhite(txt) {
  return InputDecoration(
    filled: true,
    fillColor: Colors.white,
    hintText: txt,
    labelStyle: const TextStyle(color: Colors.white),
    focusedBorder: const OutlineInputBorder(
      borderSide: BorderSide(color: Colors.white),
      borderRadius: BorderRadius.all(
        Radius.circular(5),
      ),
    ),
    enabledBorder: const OutlineInputBorder(
      borderSide: BorderSide(color: Colors.white),
      borderRadius: BorderRadius.all(
        Radius.circular(5),
      ),
    ),
  );
}

InputDecoration inputDecorationBooking(txt) {
  return InputDecoration(
    filled: true,
    fillColor: Colors.white,
    hintText: txt,
    labelStyle: const TextStyle(color: Colors.white),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.green.shade800),
      borderRadius: const BorderRadius.all(
        Radius.circular(5),
      ),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.green.shade800),
      borderRadius: const BorderRadius.all(
        Radius.circular(5),
      ),
    ),
    prefixIcon: Icon(
      Icons.location_on,
      color: Colors.green.shade800,
    ),
  );
}

InputDecoration inputDecorationBookingIcon(txt, icon) {
  return InputDecoration(
    filled: true,
    fillColor: Colors.white,
    hintText: txt,
    labelStyle: const TextStyle(color: Colors.white),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.green.shade800),
      borderRadius: const BorderRadius.only(
        topRight: Radius.circular(5),
        topLeft: Radius.circular(5),
      ),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.green.shade800),
      borderRadius: const BorderRadius.only(
        topRight: Radius.circular(5),
        topLeft: Radius.circular(5),
      ),
    ),
    prefixIcon: Icon(
      icon,
      color: Colors.green.shade800,
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

Row starsRating(qtd) {
  var starAmber = const Icon(
    Icons.star,
    size: 25,
    color: Colors.amber,
  );
  var starGrey = const Icon(
    Icons.star,
    size: 25,
    color: Colors.grey,
  );
  return Row(
    children: List.generate(5, (index) {
      return index < qtd ? starAmber : starGrey;
    }),
  );
}

Icon star() {
  return const Icon(
    Icons.star,
    size: 25,
    color: Colors.amber,
  );
}

Card iconCard(IconData icon, String txt) {
  return Card(
    elevation: 0,
    color: Colors.grey.shade50,
    child: Column(
      children: [
        Icon(
          icon,
          size: 50,
          color: Colors.green.shade800,
        ),
        Text(
          txt,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        )
      ],
    ),
  );
}

Card cardBookin(String txt) {
  return Card(
    elevation: 3,
    shape: RoundedRectangleBorder(
      side: BorderSide(
          color: Colors.green.shade800, width: 2),
      borderRadius: BorderRadius.circular(5),
    ),
    child: Padding(
      padding: const EdgeInsets.all(5),
      child: Column(
        mainAxisAlignment:
            MainAxisAlignment.center,
        crossAxisAlignment:
            CrossAxisAlignment.center,
        children: [
          Text(
            'R\$ ${txt}',
            overflow: TextOverflow.fade,
            maxLines: 1,
            softWrap: false,
            style: GoogleFonts.montserrat(
              textStyle: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.green.shade800),
            ),
          ),
        ],
      ),
    ),
  );
}

Card cardStatus(bool status, bool host) {
  return Card(
    elevation: 5,
    shape: RoundedRectangleBorder(
      side: BorderSide(
          color: Colors.green.shade800, width: 2),
      borderRadius: BorderRadius.circular(5),
    ),
    color: status == true
        ? Colors.green.shade50
        : Colors.red.shade100,
    child: Padding(
        padding: const EdgeInsets.all(10),
        child: host
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  (status == true)
                  ? Text(
                      'Ativo',
                      style: GoogleFonts.montserrat(
                        textStyle: TextStyle(
                            color: Colors.green.shade900,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    )
                  : Text(
                      'Inativo',
                      style: GoogleFonts.montserrat(
                        textStyle: TextStyle(
                            color: Colors.red.shade900,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                ],
              )
            : null),
  );
}