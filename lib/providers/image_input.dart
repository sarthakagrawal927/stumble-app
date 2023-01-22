import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageInput with ChangeNotifier {
  List<File>? _imageFiles;
  int _imageHeight = 14;
  bool _isFirstImage = false;

  void _getFromGallery() async {
    XFile? pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      if (_isFirstImage) {
        _imageFiles = <File>[File(pickedFile.path)];
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

  Widget renderElevatedButton(BuildContext context, bool isFirstImage) {
    if (isFirstImage) _imageHeight = 7;
    _isFirstImage = isFirstImage;
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        fixedSize: Size(
          (MediaQuery.of(context).size.width) / 2,
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

  Widget returnContainer(index) {
    return Image.file(
      _imageFiles![index],
      fit: BoxFit.cover,
    );
  }
}
