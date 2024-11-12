import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image/image.dart' as img;
Future<File?> pickImage(BuildContext context) async {
  final picker = ImagePicker();
  final pickedImage = await showDialog<ImageSource>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text("Select Image Source"),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              GestureDetector(
                child: const Text("Gallery"),
                onTap: () {
                  Navigator.of(context).pop(ImageSource.gallery);
                },
              ),
              const SizedBox(height: 20),
              GestureDetector(
                child: const Text("Camera"),
                onTap: () {
                  Navigator.of(context).pop(ImageSource.camera);
                },
              ),
            ],
          ),
        ),
      );
    },
  );

  if (pickedImage != null) {
    final pickedFile = await picker.pickImage(source: pickedImage);
    if (pickedFile != null) {
      if (pickedImage == ImageSource.camera) {
        return await _resizeImage(pickedFile);
      }
      return File(pickedFile.path);
    }
  }
  return null;
}

Future<File> _resizeImage(XFile pickedFile) async {
  final bytes = await pickedFile.readAsBytes();
  final image = img.decodeImage(Uint8List.fromList(bytes));

  if (image != null) {
    final resizedImage = img.copyResize(image, width: Get.width.toInt(), height: Get.height.toInt());
    final resizedFile = File(pickedFile.path)..writeAsBytesSync(img.encodeJpg(resizedImage));
    return resizedFile;
  }
  throw Exception("Failed to resize image.");
}