import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageInput with ChangeNotifier {
  List<File> imageUrls;
  ImageInput(this.imageUrls);

  int _currentImageNumber = 5;

  void getFromGallery() async {
    if (_currentImageNumber < imageUrls.length) {
      imageUrls
          .removeWhere((element) => element == imageUrls[_currentImageNumber]);
    }
    XFile? pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      imageUrls.add(File(pickedFile.path));
      notifyListeners();
    }
  }

  bool elemenExistsAt(int index) {
    if (imageUrls.length >= index + 1) return true;
    return false;
  }

  Widget renderButton(BuildContext context, int imageNumber) {
    _currentImageNumber = imageNumber;
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.black38,
        fixedSize: Size(
          (MediaQuery.of(context).size.width) / 2,
          (MediaQuery.of(context).size.height) /
              (5 * (imageNumber != 0 ? 2 : 1)),
        ),
      ),
      onPressed: getFromGallery,
      child: elemenExistsAt(imageNumber)
          ? Image.file(
              imageUrls[imageNumber],
              fit: BoxFit.fill,
            )
          : const Icon(
              Icons.camera,
              color: Colors.white,
            ),
    );
  }
}
