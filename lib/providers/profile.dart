import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../constants.dart';

class Profile with ChangeNotifier {
  String id;
  String name;
  Gender gender;
  var birthDate = {'year': 0, 'month': 0, 'day': 0};
  List<File> imageUrls = [];
  bool isVerified;
  String conversationStarterPrompt;

  Profile({
    required this.id,
    required this.name,
    required this.gender,
    required this.birthDate,
    required this.isVerified,
    required this.imageUrls, // Make this non-required as well.
    required this.conversationStarterPrompt,
  });

  // Setters

  set setName(String nameInput) {
    name = nameInput;
    notifyListeners();
  }

  set setAge(var birthDateInput) {
    birthDate = birthDateInput;
    print(birthDate);
    notifyListeners();
  }

  set setGender(Gender genderInput) {
    gender = genderInput;
    notifyListeners();
  }

  set setProfilePrompt(String conversationStarterPromptInput) {
    conversationStarterPrompt = conversationStarterPromptInput;
    print(name);
    print(birthDate);

    print(gender);

    print(conversationStarterPrompt);

    print(imageUrls[0]);

    notifyListeners();
  }

  set setFirstImage(File firstImageFile) {
    imageUrls.add(firstImageFile);
    notifyListeners();
  }

  // set setProfilePicture()

  // Getters

  String get getName {
    return name;
  }

  Gender get getGender {
    return gender;
  }

  int get getAge {
    return 20; //Have to change later.
  }

  // File get getFirstImageUrl {
  //   if (imageUrls.isEmpty) return File
  //   return imageUrls[0];
  // }

  List<File> get getImageUrls {
    return imageUrls;
  }

  bool isFirstImagePresent() {
    return imageUrls.isNotEmpty;
  }

  Future<void> getStumblesFromBackend() async {}

  Set<Profile> undoListOfProfiles = {};
  List<Profile> currentListOfStumbles = [];

  void removeLikedProfiles(Profile profile) {
    //Change this later
    currentListOfStumbles.remove(profile);
    notifyListeners();
  }

  void removeLikedProfilesWhenButtonIsClicked(
      Profile profile, String preference) {
    currentListOfStumbles.remove(profile);
    notifyListeners();
  }

  set setUndoListOfProfiles(Profile profile) {
    undoListOfProfiles.add(profile);
    notifyListeners();
  }

  void setUndoListProfilesToFrontOfGetStumblesList() {
    if (undoListOfProfiles.isNotEmpty) {
      currentListOfStumbles.add(undoListOfProfiles.last);
      undoListOfProfiles.remove(undoListOfProfiles.last);
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
      // getStumblesFromBackendAndSetCurrentList();
      currentListOfStumbles = [
        Profile(
          id: '1',
          birthDate: {},
          name: 'A',
          gender: Gender.man,
          imageUrls: [
            File(
                'https://t4.ftcdn.net/jpg/02/24/86/95/360_F_224869519_aRaeLneqALfPNBzg0xxMZXghtvBXkfIA.jpg'),
            File(
                'https://t4.ftcdn.net/jpg/02/24/86/95/360_F_224869519_aRaeLneqALfPNBzg0xxMZXghtvBXkfIA.jpg'),
          ],
          isVerified: false,
          conversationStarterPrompt: "",
        ),
        Profile(
          id: '3',
          birthDate: {},
          name: 'B',
          gender: Gender.nonBinary,
          imageUrls: [
            File(
                'https://thumbs.dreamstime.com/b/smiling-indian-man-looking-camera-mature-wearing-spectacles-portrait-middle-eastern-confident-businessman-office-195195079.jpg'),
            File(
                'https://media.istockphoto.com/photos/smiling-man-outdoors-in-the-city-picture-id1179420343?b=1&k=20&m=1179420343&s=612x612&w=0&h=c9Z3DyUg-YvgOQnL_ykTIgVTWXjF-GNo4FUQ7i5fyyk=')
          ],
          isVerified: false,
          conversationStarterPrompt: "",
        ),
        Profile(
          id: '3',
          birthDate: {},
          name: 'C',
          gender: Gender.nonBinary,
          imageUrls: [
            File(
                'https://thumbs.dreamstime.com/b/smiling-indian-man-looking-camera-mature-wearing-spectacles-portrait-middle-eastern-confident-businessman-office-195195079.jpg'),
            File(
                'https://media.istockphoto.com/photos/smiling-man-outdoors-in-the-city-picture-id1179420343?b=1&k=20&m=1179420343&s=612x612&w=0&h=c9Z3DyUg-YvgOQnL_ykTIgVTWXjF-GNo4FUQ7i5fyyk=')
          ],
          isVerified: false,
          conversationStarterPrompt: "",
        ),
        Profile(
          id: '3',
          birthDate: {},
          name: 'D',
          gender: Gender.nonBinary,
          imageUrls: [
            File(
                'https://thumbs.dreamstime.com/b/smiling-indian-man-looking-camera-mature-wearing-spectacles-portrait-middle-eastern-confident-businessman-office-195195079.jpg'),
            File(
                'https://media.istockphoto.com/photos/smiling-man-outdoors-in-the-city-picture-id1179420343?b=1&k=20&m=1179420343&s=612x612&w=0&h=c9Z3DyUg-YvgOQnL_ykTIgVTWXjF-GNo4FUQ7i5fyyk=')
          ],
          isVerified: false,
          conversationStarterPrompt: "",
        ),
        Profile(
          id: '3',
          birthDate: {},
          name: 'E',
          gender: Gender.nonBinary,
          imageUrls: [
            File(
                'https://thumbs.dreamstime.com/b/smiling-indian-man-looking-camera-mature-wearing-spectacles-portrait-middle-eastern-confident-businessman-office-195195079.jpg'),
            File(
                'https://media.istockphoto.com/photos/smiling-man-outdoors-in-the-city-picture-id1179420343?b=1&k=20&m=1179420343&s=612x612&w=0&h=c9Z3DyUg-YvgOQnL_ykTIgVTWXjF-GNo4FUQ7i5fyyk=')
          ],
          isVerified: false,
          conversationStarterPrompt: "",
        ),
        Profile(
          id: '2',
          birthDate: {},
          gender: Gender.man,
          name: 'F',
          imageUrls: [
            File(
                'https://media.istockphoto.com/photos/smiling-man-outdoors-in-the-city-picture-id1179420343?b=1&k=20&m=1179420343&s=612x612&w=0&h=c9Z3DyUg-YvgOQnL_ykTIgVTWXjF-GNo4FUQ7i5fyyk='),
            File(
                'https://media.istockphoto.com/photos/smiling-man-outdoors-in-the-city-picture-id1179420343?b=1&k=20&m=1179420343&s=612x612&w=0&h=c9Z3DyUg-YvgOQnL_ykTIgVTWXjF-GNo4FUQ7i5fyyk=')
          ],
          isVerified: false,
          conversationStarterPrompt: "",
        ),
      ];
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
