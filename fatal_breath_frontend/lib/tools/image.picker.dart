import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';

Future imagePicker() async {
  try {
    final XFile? inputImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (inputImage == null) return;

    Uint8List imageBytes = await inputImage.readAsBytes();
    String encoded = base64Url.encode(imageBytes);
    Uint8List decoded = base64.decode(encoded);
    File selectedImage = File(inputImage.path);

    Map imageInfo = {
      "selectedImage": selectedImage,
      "inputImage": inputImage,
      "imageBytes": imageBytes,
      "encoded": encoded,
      "decoded": decoded,
    };

    return imageInfo;
  } catch (e) {
    throw HttpException(e.toString());
  }
}
