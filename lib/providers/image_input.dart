import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageInput with ChangeNotifier {
  List<File>? _imageFiles = <File>[];
  int _imageHeight = 14;
  bool _isFirstImage = false;
  int currentImageNumber = 0;
  bool imageAlreadySet = false;

  void _getFromGallery() async {
    XFile? pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      if (_isFirstImage) {
        _imageFiles = [File(pickedFile.path)];
      }
      if (imageAlreadySet) {
        _imageFiles!.removeAt(currentImageNumber);
      }
      _imageFiles!.add(File(pickedFile.path));
      notifyListeners();
    }
  }

  List<File> get imageFiles {
    if (_imageFiles == null) {
      return <File>[];
    }
    return [..._imageFiles!];
  }

  bool elemenExistsAt(int index) {
    if (imageFiles.length >= index + 1) return true;
    return false;
  }

  Widget renderButton(BuildContext context, int imageNumber) {
    if (imageNumber == 0) {
      _imageHeight = 7;
      _isFirstImage = true;
    }
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        fixedSize: Size(
          (MediaQuery.of(context).size.width) / 5,
          (MediaQuery.of(context).size.height) / _imageHeight,
        ),
      ),
      onPressed: _getFromGallery,
      child: const Icon(
        Icons.camera,
        color: Colors.amber,
      ),
    );
  }

  Widget renderImage(BuildContext context, int imageNumber) {
    _imageHeight = 7;
    _isFirstImage = imageNumber == 0 ? true : false;
    if (_imageFiles!.length > imageNumber) {
      return SizedBox(
        width: (MediaQuery.of(context).size.width) / 1.25,
        height: (MediaQuery.of(context).size.height) / _imageHeight,
        child: Image.file(
          _imageFiles![imageNumber],
          fit: BoxFit.cover,
        ),
      );
    }
    return SizedBox(
      width: (MediaQuery.of(context).size.width) / 1.5,
      height: (MediaQuery.of(context).size.height) / _imageHeight,
    );
  }
}
