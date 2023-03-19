import 'dart:io';

import 'package:flutter/material.dart';

import '../providers/image_input.dart';

class Profile with ChangeNotifier {
  final String id;
  final String name;
  final double age;
  List<String> imageUrls;
  bool isVerified;
  //final String conversationStarterText;
  final List<String> conversationStarterList;

  Profile({
    required this.id,
    required this.name,
    required this.age,
    this.isVerified = false,
    required this.imageUrls,
    //required this.conversationStarterText,
    required this.conversationStarterList,
  });

  final List<File>? _images = ImageInput().imageList();
  // // Function to get the list of images.
  // List<String> get images {
  //   return [..._images];
  // }

  // // // Function to add an image to the profile.
  // void addImage(String imageUrl) {
  //   _images.add(imageUrl);
  //   notifyListeners();
  // }

  // // Function to change an image in the profile.
  // void updateImage(String id, String imageUrl) {
  //   final imageIndex = _images.indexWhere((image) => prod.id == id);
  //   if (prodIndex >= 0) {
  //     _items[prodIndex] = newProduct;
  //     notifyListeners();
  //   } else {
  //     print('...');
  //   }
  // }
}
