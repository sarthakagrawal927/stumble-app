import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../constants.dart';

class Profile with ChangeNotifier {
  String id;
  String name;
  String phoneNumber;
  Gender gender;
  var birthDate = {'year': 0, 'month': 0, 'day': 0};
  File firstimageUrl;
  File secondImageUrl;
  File thirdImageUrl;
  bool isVerified;
  String conversationStarterPrompt;
  bool nicheFilterSelected;
  RangeValues ageRangePreference;
  List<Gender> genderPreferences;

  Profile({
    required this.id,
    required this.name,
    required this.phoneNumber,
    required this.gender,
    required this.birthDate,
    required this.isVerified,
    required this.firstimageUrl,
    required this.secondImageUrl,
    required this.thirdImageUrl,
    required this.conversationStarterPrompt,
    required this.nicheFilterSelected,
    required this.ageRangePreference,
    required this.genderPreferences,
  });

  // Setters

  set setName(String nameInput) {
    name = nameInput;
    notifyListeners();
  }

  set setPhoneNumber(String phoneNumberInput) {
    phoneNumber = phoneNumberInput;
    notifyListeners();
  }

  set setAge(var birthDateInput) {
    birthDate = birthDateInput;
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

  set setFirstImage(File firstImageFile) {
    firstimageUrl = firstImageFile;
    notifyListeners();
  }

  set setSecondImage(File secondImageFile) {
    secondImageUrl = secondImageFile;
    notifyListeners();
  }

  set setThirdImage(File thirdImageFile) {
    thirdImageUrl = thirdImageFile;
    notifyListeners();
  }

  set setNicheFilterValue(bool isNicheFilterSelected) {
    nicheFilterSelected = isNicheFilterSelected;
    notifyListeners();
  }

  set setAgeRangePreference(RangeValues ageRangeValues) {
    ageRangePreference = ageRangeValues;
    notifyListeners();
  }

  set setGenderPreference(List<Gender> genderPreferencesList) {
    genderPreferences = genderPreferencesList;

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

  String get getPhoneNumber {
    return phoneNumber;
  }

  int get getAge {
    return 20; //Have to change later.
  }

  bool get getNicheFilterSelectedValue {
    return nicheFilterSelected;
  }

  // File get getFirstImageUrl {
  //   if (imageUrls.isEmpty) return File
  //   return imageUrls[0];
  // }

  File get getFirstImageUrl {
    return firstimageUrl;
  }

  File get getSecondImageUrl {
    return secondImageUrl;
  }

  File get getThirdImageUrl {
    return thirdImageUrl;
  }

  bool isFirstImagePresent() {
    return firstimageUrl.isAbsolute;
  }

  bool isSecondImagePresent() {
    return secondImageUrl.isAbsolute;
  }

  bool isThirdImagePresent() {
    return thirdImageUrl.isAbsolute;
  }

  Future<void> getStumblesFromBackend() async {}

  Set<Profile> undoListOfProfiles = {};
  List<Profile> currentListOfStumbles = [];
  List<Profile> likedListOfProfiles = [];
  List<Profile> admirerListOfProfiles = [];

  void removeLikedProfiles(Profile profile) {
    //Change this later
    currentListOfStumbles.remove(profile);
    notifyListeners();
  }

  void removeLikedProfilesWhenButtonIsClicked(Profile profile, Widget widget,
      String comment, String preference, SwipeType swipeType) {
    if (swipeType == SwipeType.swipe) {
      currentListOfStumbles.remove(profile);
    } else if (swipeType == SwipeType.comment) {
      // Add code for storing comment.
      currentListOfStumbles.remove(profile);
    } else if (swipeType == SwipeType.nicheSelection) {
      // Add code for storing nicheValue
      currentListOfStumbles.remove(profile);
    }
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

  set setLikedListOfProfiles(Profile profile) {
    likedListOfProfiles.add(profile);
    notifyListeners();
  }

  List<Profile> getLikedListOfProfiles() {
    return likedListOfProfiles;
  }

  set setStumbledOntoMeListOfProfiles(Profile profile) {
    admirerListOfProfiles.add(profile);
    notifyListeners();
  }

  List<Profile> getStumbledOntoMeListOfProfiles() {
    return admirerListOfProfiles;
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
          phoneNumber: '1234567890',
          gender: Gender.man,
          firstimageUrl: File(
              'https://t4.ftcdn.net/jpg/02/24/86/95/360_F_224869519_aRaeLneqALfPNBzg0xxMZXghtvBXkfIA.jpg'),
          secondImageUrl: File(
              'https://t4.ftcdn.net/jpg/02/24/86/95/360_F_224869519_aRaeLneqALfPNBzg0xxMZXghtvBXkfIA.jpg'),
          thirdImageUrl: File(""),
          isVerified: false,
          conversationStarterPrompt: "",
          nicheFilterSelected: false,
          genderPreferences: [],
          ageRangePreference: const RangeValues(18, 40),
        ),
        Profile(
          id: '3',
          birthDate: {},
          name: 'B',
          phoneNumber: '1234567890',
          gender: Gender.nonBinary,
          firstimageUrl: File(
              'https://thumbs.dreamstime.com/b/smiling-indian-man-looking-camera-mature-wearing-spectacles-portrait-middle-eastern-confident-businessman-office-195195079.jpg'),
          secondImageUrl: File(
              'https://media.istockphoto.com/photos/smiling-man-outdoors-in-the-city-picture-id1179420343?b=1&k=20&m=1179420343&s=612x612&w=0&h=c9Z3DyUg-YvgOQnL_ykTIgVTWXjF-GNo4FUQ7i5fyyk='),
          thirdImageUrl: File(""),
          isVerified: false,
          conversationStarterPrompt: "",
          nicheFilterSelected: false,
          genderPreferences: [],
          ageRangePreference: const RangeValues(18, 40),
        ),
        Profile(
          id: '3',
          birthDate: {},
          name: 'C',
          phoneNumber: '1234567890',
          gender: Gender.nonBinary,
          firstimageUrl: File(
              'https://thumbs.dreamstime.com/b/smiling-indian-man-looking-camera-mature-wearing-spectacles-portrait-middle-eastern-confident-businessman-office-195195079.jpg'),
          secondImageUrl: File(
              'https://media.istockphoto.com/photos/smiling-man-outdoors-in-the-city-picture-id1179420343?b=1&k=20&m=1179420343&s=612x612&w=0&h=c9Z3DyUg-YvgOQnL_ykTIgVTWXjF-GNo4FUQ7i5fyyk='),
          thirdImageUrl: File(""),
          isVerified: false,
          conversationStarterPrompt: "",
          nicheFilterSelected: true,
          genderPreferences: [],
          ageRangePreference: const RangeValues(18, 40),
        ),
        Profile(
          id: '3',
          birthDate: {},
          name: 'D',
          phoneNumber: '1234567890',
          gender: Gender.nonBinary,
          firstimageUrl: File(
              'https://thumbs.dreamstime.com/b/smiling-indian-man-looking-camera-mature-wearing-spectacles-portrait-middle-eastern-confident-businessman-office-195195079.jpg'),
          secondImageUrl: File(
              'https://media.istockphoto.com/photos/smiling-man-outdoors-in-the-city-picture-id1179420343?b=1&k=20&m=1179420343&s=612x612&w=0&h=c9Z3DyUg-YvgOQnL_ykTIgVTWXjF-GNo4FUQ7i5fyyk='),
          thirdImageUrl: File(""),
          isVerified: false,
          conversationStarterPrompt: "",
          nicheFilterSelected: true,
          genderPreferences: [],
          ageRangePreference: const RangeValues(18, 40),
        ),
        Profile(
          id: '3',
          birthDate: {},
          name: 'E',
          phoneNumber: '1234567890',
          gender: Gender.nonBinary,
          firstimageUrl: File(
              'https://thumbs.dreamstime.com/b/smiling-indian-man-looking-camera-mature-wearing-spectacles-portrait-middle-eastern-confident-businessman-office-195195079.jpg'),
          secondImageUrl: File(
              'https://media.istockphoto.com/photos/smiling-man-outdoors-in-the-city-picture-id1179420343?b=1&k=20&m=1179420343&s=612x612&w=0&h=c9Z3DyUg-YvgOQnL_ykTIgVTWXjF-GNo4FUQ7i5fyyk='),
          thirdImageUrl: File(""),
          isVerified: false,
          conversationStarterPrompt: "",
          nicheFilterSelected: false,
          genderPreferences: [],
          ageRangePreference: const RangeValues(18, 40),
        ),
        Profile(
          id: '2',
          birthDate: {},
          gender: Gender.man,
          name: 'F',
          phoneNumber: '1234567890',
          firstimageUrl: File(
              'https://media.istockphoto.com/photos/smiling-man-outdoors-in-the-city-picture-id1179420343?b=1&k=20&m=1179420343&s=612x612&w=0&h=c9Z3DyUg-YvgOQnL_ykTIgVTWXjF-GNo4FUQ7i5fyyk='),
          secondImageUrl: File(
              'https://media.istockphoto.com/photos/smiling-man-outdoors-in-the-city-picture-id1179420343?b=1&k=20&m=1179420343&s=612x612&w=0&h=c9Z3DyUg-YvgOQnL_ykTIgVTWXjF-GNo4FUQ7i5fyyk='),
          thirdImageUrl: File(""),
          isVerified: false,
          conversationStarterPrompt: "",
          nicheFilterSelected: true,
          genderPreferences: [],
          ageRangePreference: const RangeValues(18, 40),
        ),
      ];
    }
    return currentListOfStumbles;
  }

  bool isOTPCorrect(String verificationCode) {
    // Call backend API for whatsapp OTP
    return (verificationCode == "1111");
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
