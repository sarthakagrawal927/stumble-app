import 'dart:io';

import 'package:chucker_flutter/chucker_flutter.dart';
import 'package:dating_made_better/global_store.dart';
import 'package:dating_made_better/utils/call_api.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import '../constants.dart';

class Profile with ChangeNotifier {
  int id;
  String name;
  String phoneNumber;
  int age;
  Gender gender;
  DateTime birthDate;
  List<File> photos = [];
  bool photoVerified;
  String conversationStarter;
  bool nicheFilterSelected;
  RangeValues ageRangePreference;
  List<Gender> genderPreferences;
  String bearerToken = AppConstants.token;
  double profileCompletionAmount = 0.0;

  // https://stackoverflow.com/questions/67126549/flutter-define-default-value-of-a-datetime-in-constructor
  Profile({
    required this.id,
    required this.name,
    this.phoneNumber = "",
    required this.gender,
    this.age = 22,
    DateTime? birthDate,
    this.photos = const [],
    this.photoVerified = true,
    this.conversationStarter = "Hi there, I am on Stumble!",
    this.nicheFilterSelected = false,
    this.ageRangePreference = const RangeValues(18, 30),
    this.genderPreferences = const [Gender.man],
  }) : birthDate = birthDate ?? DateTime.now();

  final url = 'https://stumbe.onrender.com';
  final _chuckerHttpClient = ChuckerHttpClient(http.Client());
  int currentUser = -1;
  String currentThreadId = "";
  var logger = Logger();

  // Setters

  set setName(String nameInput) {
    name = nameInput;
    notifyListeners();
  }

  set setPhoneNumber(String phoneNumberInput) {
    phoneNumber = phoneNumberInput;
    notifyListeners();
  }

  set setBirthDate(DateTime birthDateInput) {
    birthDate = birthDateInput;
    notifyListeners();
  }

  set setAge(int age) {
    age = age;
    notifyListeners();
  }

  set setGender(Gender genderInput) {
    gender = genderInput;
    notifyListeners();
  }

  set setProfilePrompt(String conversationStarterPromptInput) {
    conversationStarter = conversationStarterPromptInput;
    profileCompletionAmount += 1;
    // as this is the last screen need to call upsertUser
    notifyListeners();
  }

  set addImage(File firstImage) {
    photos.add(firstImage);
    profileCompletionAmount += 1;
    notifyListeners();
  }

  set setSecondImage(File secondImageFile) {
    photos.add(secondImageFile);
    profileCompletionAmount += 1;
    notifyListeners();
  }

  set setThirdImage(File thirdImageFile) {
    photos.add(thirdImageFile);
    profileCompletionAmount += 1;
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

  set setVerificationStatus(bool currentStatus) {
    setVerificationStatus = currentStatus;
    if (currentStatus) {
      profileCompletionAmount += 1;
    }
    notifyListeners();
  }

  // Getters

  String get getName {
    return name;
  }

  int get getAge {
    return age;
  }

  String get getPhone {
    return phoneNumber;
  }

  bool get getPhotoVerificationStatus {
    return photoVerified;
  }

  File get getFirstImageUrl {
    return photos[0];
  }

  File get getSecondImageUrl {
    return photos[0];
  }

  File get getThirdImageUrl {
    return photos[0];
  }

  String get getConversationStarterPrompt {
    return conversationStarter;
  }

  List<Gender> get getGenderPreferencesList {
    return genderPreferences;
  }

  RangeValues get getAgeRangePreference {
    return ageRangePreference;
  }

  double get getPercentageOfProfileCompleted {
    profileCompletionAmount =
        profileCompletionAmount > 5 ? 5 : profileCompletionAmount;
    return profileCompletionAmount * 100 / 5;
  }

  bool isFirstImagePresent() {
    return photos.isNotEmpty && photos[0].isAbsolute && photos[0] != File("");
  }

  bool isSecondImagePresent() {
    return photos.length > 1 && photos[1].isAbsolute && photos[1] != File("");
  }

  bool isThirdImagePresent() {
    return photos.length > 2 && photos[2].isAbsolute && photos[2] != File("");
  }

  Set<Profile> undoListOfProfilesForCurrentUser = {};
  List<Profile> currentListOfStumblesForCurrentUser = [];

  List<dynamic> likedListOfProfilesForCurrentUser = [];
  List<dynamic> admirerListOfProfilesForCurrentUser = [];
  List<dynamic> threadsListForCurrentUser = [];
  List<dynamic> messagesListForCorrespondingThread = [];

  List<dynamic> get getMessagesList {
    return messagesListForCorrespondingThread;
  }

  void addMessageToMessagesList(var message) {
    messagesListForCorrespondingThread.add(message);
    notifyListeners();
  }

  void deleteMessageFromMessagesList(int messageId) {
    for (var messageObject in messagesListForCorrespondingThread) {
      if (messageObject['id'] == messageId) {
        messagesListForCorrespondingThread.remove(messageObject);
        break;
      }
    }
    notifyListeners();
  }

  void removeLikedProfilesWhenNicheButtonIsClicked(Profile profile,
      Widget widget, String comment, String preference, SwipeType swipeType) {
    if (swipeType == SwipeType.swipe) {
      currentListOfStumblesForCurrentUser.remove(profile);
    } else if (swipeType == SwipeType.comment) {
      // Add code for storing comment.
      currentListOfStumblesForCurrentUser.remove(profile);
    } else if (swipeType == SwipeType.nicheSelection) {
      // Add code for storing nicheValue
      currentListOfStumblesForCurrentUser.remove(profile);
    }
    notifyListeners();
  }

  void setUndoListProfilesToFrontOfGetStumblesList() {
    if (undoListOfProfilesForCurrentUser.isNotEmpty) {
      currentListOfStumblesForCurrentUser
          .add(undoListOfProfilesForCurrentUser.last);
      undoListOfProfilesForCurrentUser
          .remove(undoListOfProfilesForCurrentUser.last);
    }
    notifyListeners();
  }

  set setLikedListOfProfiles(Profile profile) {
    likedListOfProfilesForCurrentUser.add(profile);
    notifyListeners();
  }

  // INTEGRATION API
  Future<void> deleteMessageAPI(int messageId, int receiverId) async {
    final urlToCallDeleteMessageFromBackend = '$url/api/v1/chat/delete';
    try {
      final response = await _chuckerHttpClient
          .post(Uri.parse(urlToCallDeleteMessageFromBackend), body: {
        'messageId': messageId.toString(),
        'receiverId': receiverId.toString(),
      }, headers: {
        'Authorization': bearerToken
      });
      logger.i("Data of delete message: ${response.body}");
    } catch (error) {
      rethrow;
    }
  }

  Future<void> upsertUser() async {
    var profile = await upsertUserApi({
      "name": name,
      "gender": gender.index,
      "dob": birthDate.toIso8601String(),
      "conversation_starter": conversationStarter,
      "photos": photos.map((e) => e.path).toList(),
    });
  }

  static fromJson(profile) {
    return Profile(
      id: profile["id"],
      name: profile["name"],
      gender: Gender.values[profile["gender"]],
      conversationStarter: profile["conversation_starter"],
      age: profile["age"] ?? 22,
      photoVerified: profile["photo_verified"],
      photos: profile["photos"] ?? [],
    );
  }
}
