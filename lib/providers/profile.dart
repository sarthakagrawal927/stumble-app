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
    required this.imageUrls, // Make this non-required as well.
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

  Future<void> getStumblesFromBackend() async {}

  List<Profile> undoListOfProfiles = [];
  List<Profile> currentListOfStumbles = [];

  List<Profile> get getUndoListOfProfiles {
    return undoListOfProfiles;
  }

  void removeLikedProfiles(int index) {
    //Change this later
    currentListOfStumbles.removeAt(index);
    notifyListeners();
  }

  set setUndoListOfProfiles(Profile profile) {
    undoListOfProfiles.add(profile);
    notifyListeners();
  }

  void setUndoListProfilesToFrontOfGetStumblesList() {
    if (undoListOfProfiles.isNotEmpty) {
      currentListOfStumbles.insert(0, undoListOfProfiles.last);
      undoListOfProfiles.removeLast;
    }
    notifyListeners();
  }

  Future<void> getStumblesFromBackendAndSetCurrentList() async {
    const url = 'http://localhost:8000';
    try {
      final response = await http.get(Uri.parse(url));
      if (response.body.isEmpty) {
        return;
      }
      //userProfiles = response.body; // Return list from getStumbles API
      // notifyListeners();
      // ignore: empty_catches
    } catch (error) {}
  }

  List<Profile> get getCurrentListOfCachedStumbles {
    if (currentListOfStumbles.isEmpty) {
      getStumblesFromBackendAndSetCurrentList();
    }
    return currentListOfStumbles;
  }

  // Future<void> setUserData() async { // Complete this function.
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
