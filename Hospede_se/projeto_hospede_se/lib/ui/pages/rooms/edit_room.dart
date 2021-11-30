import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:projeto_hospede_se/helpers/validators.dart';
import 'package:projeto_hospede_se/models/room.dart';
import 'package:projeto_hospede_se/ui/pages/components/images_form.dart';
import 'package:projeto_hospede_se/ui/styles/style.dart';

class EditRoomPage extends StatefulWidget {
  EditRoomPage({Key? key, required this.room}) : super(key: key);

  final Room room;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  State<EditRoomPage> createState() => _EditRoomPageState();
}

class _EditRoomPageState extends State<EditRoomPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green.shade800,
        title: const Text('Editar Quarto'),
        centerTitle: true,
      ),
      body: Form(
        key: widget.formKey,
        child: ListView(
          children: <Widget>[
            ImagesForm(room: widget.room),
            Padding(
              padding:
                  const EdgeInsets.only(left: 16, right: 16, bottom: 8, top: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  TextFormField(
                    initialValue: widget.room.title,
                    decoration: const InputDecoration(
                      hintText: 'Título',
                      border: InputBorder.none,
                    ),
                    style: GoogleFonts.montserrat(
                      textStyle: const TextStyle(
                          fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                    validator: (title) => Validators.validateText(title!),
                  ),
                  TextFormField(
                    initialValue: widget.room.description,
                    maxLines: 4,
                    validator: (description) =>
                        Validators.validateText(description!),
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                    ),
                    style: GoogleFonts.montserrat(
                      textStyle: const TextStyle(fontSize: 20),
                    ),
                  ),
                  Text(
                    'Número',
                    style: GoogleFonts.montserrat(
                      textStyle: const TextStyle(
                          fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                  ),
                  TextFormField(
                    initialValue: widget.room.number.toString(),
                    validator: (number) => Validators.validateText(number!),
                    decoration: const InputDecoration(
                      hintText: 'Número',
                      border: InputBorder.none,
                    ),
                    keyboardType: TextInputType.number,
                    style: GoogleFonts.montserrat(
                      textStyle: const TextStyle(fontSize: 20),
                    ),
                  ),
                  TextFormField(
                    initialValue: widget.room.guestCount.toString(),
                    validator: (guestCount) =>
                        Validators.validateNumber(guestCount!),
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      icon: Icon(
                        Icons.person_outline,
                        size: 40,
                        color: Colors.green,
                      ),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                  TextFormField(
                    initialValue: widget.room.bedCount.toString(),
                    validator: (bedCount) =>
                        Validators.validateNumber(bedCount!),
                    decoration:
                        inputDecorationSignUp('Camas', const Icon(Icons.add)),
                    keyboardType: TextInputType.number,
                  ),
                  TextFormField(
                    initialValue: widget.room.bathCount.toString(),
                    validator: (bathCount) =>
                        Validators.validateNumber(bathCount!),
                    decoration: inputDecorationSignUp(
                        'Banheiros', const Icon(Icons.add)),
                    keyboardType: TextInputType.number,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (widget.formKey.currentState!.validate()) {
                        print('válido!');
                      }
                    },
                    child: const Text('Salvar'),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.green.shade800,
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
