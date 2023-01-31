import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageInput with ChangeNotifier {
  List<File>? _imageFiles = <File>[];
  int _currentImageNumber = 5;

  void getFromGallery() async {
    if (_currentImageNumber < _imageFiles!.length) {
      _imageFiles!.removeWhere(
          (element) => element == _imageFiles![_currentImageNumber]);
    }
    XFile? pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      _imageFiles!.add(File(pickedFile.path));
    }
    notifyListeners();
  }

  List<File>? imageList() {
    if (_imageFiles == null) {
      return <File>[];
    }
    return [..._imageFiles!];
  }

  bool elemenExistsAt(int index) {
    if (_imageFiles!.length >= index + 1) return true;
    return false;
  }

  Widget renderButton(BuildContext context, int imageNumber) {
    _currentImageNumber = imageNumber;

    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        fixedSize: Size(
          (MediaQuery.of(context).size.width) / 5,
          (MediaQuery.of(context).size.height) / 7,
        ),
      ),
      onPressed: getFromGallery,
      child: const Icon(
        Icons.camera,
        color: Colors.amber,
      ),
    );
  }

  Widget renderImage(BuildContext context, int imageNumber) {
    return Container(
      height: (MediaQuery.of(context).size.height) / 7,
      width: (MediaQuery.of(context).size.width) / 5 * 4,
      child: elemenExistsAt(imageNumber)
          ? Image.file(
              _imageFiles![imageNumber],
              fit: BoxFit.cover,
            )
          : Text(
              "Add image!",
              textAlign: TextAlign.center,
            ),
    );
  }
}
