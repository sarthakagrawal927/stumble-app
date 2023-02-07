import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageInput with ChangeNotifier {
  List<File>? _imageFiles = <File>[];
  int _currentImageNumber = 5;

  void getFromGallery() async {
    for (var element in _imageFiles!) {
      print("Initially." + _currentImageNumber.toString());
      print(element);
    }
    if (_currentImageNumber < _imageFiles!.length) {
      _imageFiles!.removeWhere(
          (element) => element == _imageFiles![_currentImageNumber]);
    }
    for (var element in _imageFiles!) {
      print("After deletion." + _currentImageNumber.toString());

      print(element);
    }
    XFile? pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      _imageFiles!.add(File(pickedFile.path));
    }
    for (var element in _imageFiles!) {
      print("After addition." + _currentImageNumber.toString());
      print(element);
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
          (MediaQuery.of(context).size.width) / 2,
          (MediaQuery.of(context).size.height) /
              (5 * (imageNumber != 0 ? 2 : 1)),
        ),
      ),
      onPressed: getFromGallery,
      child: elemenExistsAt(imageNumber)
          ? Image.file(
              _imageFiles![imageNumber],
              fit: BoxFit.fill,
            )
          : const Icon(
              Icons.camera,
              color: Colors.amber,
            ),
    );
  }
}
