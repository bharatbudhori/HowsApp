import 'dart:io';

//import 'package:enough_giphy_flutter/enough_giphy_flutter.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void showSnackBar({required BuildContext context, required String content}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(content),
    ),
  );
}

Future<File?> pickImageFromGallery(BuildContext context) async {
  File? image;

  try {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      image = File(pickedImage.path);
    }
  } catch (e) {
    showSnackBar(context: context, content: e.toString());
  }

  return image;
}

Future<File?> pickViedeoFromGallery(BuildContext context) async {
  File? viedeo;

  try {
    final pickedViedeo =
        await ImagePicker().pickVideo(source: ImageSource.gallery);

    if (pickedViedeo != null) {
      viedeo = File(pickedViedeo.path);
    }
  } catch (e) {
    showSnackBar(context: context, content: e.toString());
  }

  return viedeo;
}

/*Future<GiphyGif?> pickGIF(BuildContext context) async {
  // moar6jWnjHdl8AJdGKSXKXBsFB1ox2Bj
  GiphyGif? gif;
  try {
    gif = await Giphy.getGif(
      context: context,
      apiKey: 'moar6jWnjHdl8AJdGKSXKXBsFB1ox2Bj',
    );
  } catch (e) {
    showSnackBar(context: context, content: e.toString());
  }
  return gif;
}*/
