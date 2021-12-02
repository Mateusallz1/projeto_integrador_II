// ignore_for_file: use_key_in_widget_constructors

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:cross_file/cross_file.dart';

class ImageSourceSheet extends StatelessWidget {
  ImageSourceSheet({required this.onImagesSelected});

  final Function onImagesSelected;

  final ImagePicker picker = ImagePicker();

  Future<void> editImage(List<String> path, BuildContext context) async {
    List<File> listCroppedsFiles = [];

    for (var i = 0; i < path.length; i++) {
      final File? croppedFile = await ImageCropper.cropImage(
        sourcePath: path[i],
        aspectRatio: const CropAspectRatio(ratioX: 1.0, ratioY: 1.0),
        androidUiSettings: AndroidUiSettings(
          toolbarTitle: 'Editar Imagem',
          toolbarColor: Colors.green.shade800,
          toolbarWidgetColor: Colors.white,
          backgroundColor: Colors.white,
        ),
      );
      listCroppedsFiles.add(croppedFile!);
    }
    for (var i = 0; i < listCroppedsFiles.length; i++) {
      await onImagesSelected(listCroppedsFiles[i]);
    }
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return BottomSheet(
      onClosing: () {},
      builder: (_) => Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Colors.green.shade800,
              minimumSize: const Size.fromHeight(50),
            ),
            onPressed: () async {
              final List<XFile>? images = await picker.pickMultiImage();
              List<String> listImages = [];
              for (var i = 0; i < images!.length; i++) {
                listImages.add(images[i].path);
              }
              editImage(listImages, context);
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
