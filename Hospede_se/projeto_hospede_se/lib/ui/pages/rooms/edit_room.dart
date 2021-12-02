import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:projeto_hospede_se/helpers/validators.dart';
import 'package:projeto_hospede_se/models/room.dart';
import 'package:projeto_hospede_se/models/room_manager.dart';
import 'package:projeto_hospede_se/ui/pages/components/images_form.dart';
import 'package:projeto_hospede_se/ui/pages/rooms/room_detail.dart';
import 'package:provider/provider.dart';

class EditRoomPage extends StatefulWidget {
  // ignore: unnecessary_null_comparison
  EditRoomPage({Key? key, required Room r, required this.id})
      : room = r != null
            ? r.clone()
            : Room(
                bathCount: null,
                bedCount: null,
                description: '',
                guestCount: null,
                hotelId: '',
                images: [],
                number: null,
                price: null,
                quantity: null,
                status: null,
                title: ''),
        super(key: key);

  final Room room;

  final String? id;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  State<EditRoomPage> createState() => _EditRoomPageState();
}

class _EditRoomPageState extends State<EditRoomPage> {
  @override
  Widget build(BuildContext context) {
    widget.room.id = widget.id;
    return ChangeNotifierProvider.value(
      value: widget.room,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green.shade800,
          title: const Text('Editar Quarto'),
          centerTitle: true,
        ),
        body: Form(
          key: widget.formKey,
          child: ListView(
            children: <Widget>[
              ImagesForm(
                room: widget.room,
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 16, right: 16, bottom: 8, top: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    TextFormField(
                      initialValue: widget.room.title,
                      decoration: const InputDecoration(
                        hintText: 'Título',
                      ),
                      style: GoogleFonts.montserrat(
                        textStyle: const TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                      validator: (title) => Validators.validateText(title!),
                      onSaved: (title) => widget.room.title = title,
                    ),
                    TextFormField(
                      initialValue: widget.room.description,
                      maxLines: 4,
                      validator: (description) =>
                          Validators.validateText(description!),
                      decoration: const InputDecoration(),
                      style: GoogleFonts.montserrat(
                        textStyle: const TextStyle(fontSize: 20),
                      ),
                      onSaved: (description) =>
                          widget.room.description = description,
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
                      validator: (number) => Validators.validateNumber(number!),
                      decoration: const InputDecoration(
                        hintText: 'Número',
                      ),
                      keyboardType: TextInputType.number,
                      style: GoogleFonts.montserrat(
                        textStyle: const TextStyle(fontSize: 20),
                      ),
                      onSaved: (number) =>
                          widget.room.number = int.parse(number!),
                    ),
                    TextFormField(
                      initialValue: widget.room.guestCount.toString(),
                      validator: (guestCount) =>
                          Validators.validateNumber(guestCount!),
                      decoration: const InputDecoration(
                        icon: Icon(
                          Icons.person_outline,
                          size: 40,
                          color: Colors.green,
                        ),
                      ),
                      keyboardType: TextInputType.number,
                      onSaved: (guestCount) =>
                          widget.room.guestCount = int.parse(guestCount!),
                    ),
                    TextFormField(
                      initialValue: widget.room.bedCount.toString(),
                      validator: (bedCount) =>
                          Validators.validateNumber(bedCount!),
                      decoration: const InputDecoration(
                        icon: Icon(
                          Icons.bed,
                          size: 40,
                          color: Colors.green,
                        ),
                      ),
                      keyboardType: TextInputType.number,
                      onSaved: (bedCount) =>
                          widget.room.bedCount = int.parse(bedCount!),
                    ),
                    TextFormField(
                      initialValue: widget.room.bathCount.toString(),
                      validator: (bathCount) =>
                          Validators.validateNumber(bathCount!),
                      decoration: const InputDecoration(
                        icon: Icon(
                          Icons.bathtub_outlined,
                          size: 40,
                          color: Colors.green,
                        ),
                      ),
                      keyboardType: TextInputType.number,
                      onSaved: (bathCount) =>
                          widget.room.bathCount = int.parse(bathCount!),
                    ),
                    const SizedBox(height: 20),
                    Consumer<Room>(
                      builder: (_, room, __) {
                        return SizedBox(
                          height: 44,
                          child: ElevatedButton(
                            onPressed: !room.loading
                                ? () async {
                                    if (widget.formKey.currentState!
                                        .validate()) {
                                      widget.formKey.currentState!.save();
                                      await widget.room.updateRoom();
                                      await context
                                          .read<RoomManager>()
                                          .update(room);
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => RoomScreen(
                                            context
                                                .read<RoomManager>()
                                                .hotelRooms
                                                .firstWhere(
                                                    (e) => e.id == room.id),
                                          ),
                                        ),
                                      );
                                    }
                                  }
                                : null,
                            child: room.loading
                                ? const CircularProgressIndicator(
                                    valueColor:
                                        AlwaysStoppedAnimation(Colors.white),
                                  )
                                : const Text('Salvar'),
                            style: ElevatedButton.styleFrom(
                              primary: Colors.green.shade800,
                              textStyle: GoogleFonts.montserrat(
                                textStyle: const TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w700),
                              ),
                            ),
                          ),
                        );
                      },
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
