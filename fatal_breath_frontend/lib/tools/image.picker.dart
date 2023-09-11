import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';

Future<Map<String, dynamic>> imagePicker() async {
  try {
    final XFile? inputImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (inputImage == null) {
      throw const HttpException("Image selection canceled");
    }

    // Uint8List imageBytes = await inputImage.readAsBytes();
    File selectedImage = File(inputImage.path);
    Uint8List imageBytes = selectedImage.readAsBytesSync();
    String encoded = base64Encode(imageBytes);
    Uint8List decoded = base64Decode(encoded);

    // debugPrint("encoded  $encoded");

    Map<String, dynamic> imageInfo = {
      "selectedImage": selectedImage,
      "inputImage": inputImage,
      "imageBytes": imageBytes,
      "encoded": encoded,
      "decoded": decoded,
    };

    return imageInfo;
  } catch (e) {
    throw HttpException('Image selection failed: $e');
  }
}
