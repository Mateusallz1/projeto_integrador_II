import 'package:flutter/material.dart';
import 'package:projeto_hospede_se/models/room.dart';
import 'package:projeto_hospede_se/ui/pages/components/images_form.dart';

class EditRoomPage extends StatefulWidget {
  const EditRoomPage({Key? key, required this.room}) : super(key: key);

  final Room room;

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
      body: ListView(
        children: <Widget>[ImagesForm(room: widget.room)],
      ),
    );
  }
}
