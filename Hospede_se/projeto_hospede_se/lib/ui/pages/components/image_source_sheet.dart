// ignore_for_file: use_key_in_widget_constructors

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cross_file/cross_file.dart';

class ImageSourceSheet extends StatelessWidget {
  ImageSourceSheet({required this.onImageSelected, required this.onImagesSelected});

  final Function onImageSelected;

  final Function onImagesSelected;

  final ImagePicker picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return BottomSheet(
      onClosing: () {},
      builder: (_) => Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Colors.green.shade800,
              minimumSize: const Size.fromHeight(50),
            ),
            onPressed: () async {
              final XFile? photo = await picker.pickImage(source: ImageSource.camera);
              onImageSelected(photo!.path);
            },
            child: Row(
              children: const [
                Padding(
                  padding: EdgeInsets.all(5),
                  child: Icon(Icons.add_a_photo),
                ),
                Text('Câmera'),
              ],
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Colors.green.shade800,
              minimumSize: const Size.fromHeight(50),
            ),
            onPressed: () async {
              final List<XFile>? images = await picker.pickMultiImage();
              List<File> listImages = [];
              for (var i = 0; i < images!.length; i++) {
                listImages.add(File(images[i].path));
              }
              onImagesSelected(listImages);
            },
            child: Row(
              children: const [
                Padding(
                  padding: EdgeInsets.all(5),
                  child: Icon(
                    Icons.image_search,
                    size: 28,
                  ),
                ),
                Text('Galeria'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
