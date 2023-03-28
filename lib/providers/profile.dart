import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../constants.dart';

class Profile with ChangeNotifier {
  String id;
  String name;
  Gender gender;
  double age;
  List<File> imageUrls = [];
  bool isVerified;
  String conversationStarterPrompt;

  Profile({
    this.id = "",
    this.name = "",
    this.gender = Gender.nonBinary,
    this.age = 0.0,
    this.isVerified = false,
    required this.imageUrls, // TODO: make this non-required as well.
    this.conversationStarterPrompt = "",
  });

  // Setters

  set setName(String nameInput) {
    name = nameInput;
    notifyListeners();
  }

  set setGender(Gender genderInput) {
    gender = genderInput;
    notifyListeners();
  }

  set setProfilePrompt(String conversationStarterPromptInput) {
    conversationStarterPrompt = conversationStarterPromptInput;
    notifyListeners();
  }

  // Getters

  String get getName {
    return name;
  }

  Gender get getGender {
    return gender;
  }

  List<File> get getImageUrls {
    return imageUrls;
  }

  // Future<void> setUserData() async { // TODO: Complete this function.
  //   final url = 'http://localhost:8000';
  //   try {
  //     final response = await http.get(Uri.parse(url));
  //   } catch (error) {
  //     print(error);
  //   }
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
