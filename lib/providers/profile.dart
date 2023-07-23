import 'dart:convert';
import 'dart:io';

import 'package:chucker_flutter/chucker_flutter.dart';
import 'package:dating_made_better/global_store.dart';
import 'package:dating_made_better/utils/call_api.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:path/path.dart';
import '../constants.dart';

class Profile with ChangeNotifier {
  String id;
  String name;
  String phoneNumber;
  Gender gender;
  String birthDate;
  File firstImageUrl = File("");
  File secondImageUrl = File("");
  File thirdImageUrl = File("");
  bool isVerified;
  String conversationStarterPrompt;
  bool nicheFilterSelected;
  RangeValues ageRangePreference;
  List<Gender> genderPreferences;
  String bearerToken = AppConstants.token;

  Profile({
    required this.id,
    required this.name,
    required this.phoneNumber,
    required this.gender,
    required this.birthDate,
    required this.isVerified,
    required this.firstImageUrl,
    required this.secondImageUrl,
    required this.thirdImageUrl,
    required this.conversationStarterPrompt,
    required this.nicheFilterSelected,
    required this.ageRangePreference,
    required this.genderPreferences,
  });

  final url = 'http://192.168.1.3:8080';
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

  set setAge(String birthDateInput) {
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
    firstImageUrl = firstImageFile;
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

  // Getters

  int get getAge {
    return 20;
  }

  String get getPhone {
    return phoneNumber;
  }

  File get getFirstImageUrl {
    return firstImageUrl;
  }

  File get getSecondImageUrl {
    return secondImageUrl;
  }

  File get getThirdImageUrl {
    return thirdImageUrl;
  }

  bool isFirstImagePresent() {
    return firstImageUrl.isAbsolute && firstImageUrl != File("");
  }

  bool isSecondImagePresent() {
    return secondImageUrl.isAbsolute && secondImageUrl != File("");
  }

  bool isThirdImagePresent() {
    return thirdImageUrl.isAbsolute && thirdImageUrl.path.isNotEmpty;
  }

  Set<Profile> undoListOfProfilesForCurrentUser = {};
  List<Profile> currentListOfStumblesForCurrentUser = [];
  List<dynamic> currentListOfMatchesForCurrentUser = [];
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

  void removeLikedProfiles(Profile profile) {
    //Change this later
    currentListOfStumblesForCurrentUser.remove(profile);
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

  set setUndoListOfProfiles(Profile profile) {
    undoListOfProfilesForCurrentUser.add(profile);
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

  List<dynamic> getLikedListOfProfiles() {
    // getProfilesWhoCurrentUserHasLikedAPI();
    return likedListOfProfilesForCurrentUser;
  }

  List<dynamic> getStumbledOntoMeListOfProfiles() {
    // getProfilesWhichHaveLikedCurrentUserAPI();
    return admirerListOfProfilesForCurrentUser;
  }

  List<Profile> get getCurrentListOfCachedStumbles {
    if (currentListOfStumblesForCurrentUser.isEmpty) {
      // getPotentialStumblesFromBackend();
      if (currentListOfStumblesForCurrentUser.isEmpty) {
        currentListOfStumblesForCurrentUser = constantListOfStumbles;
      }
    }
    return currentListOfStumblesForCurrentUser;
  }

  // INTEGRATION APIs

  Future<void> createUserAPI() async {
    try {
      upsertUserApi({
        "name": name,
        "phone": phoneNumber,
        "dob": birthDate,
        "gender": gender == Gender.man
            ? "1"
            : gender == Gender.woman
                ? "2"
                : "3",
        "conversation_starter": conversationStarterPrompt,
        // "photo_verified": isVerified,
        // 'firstImageUrl': firstImageUrl,
        // 'secondImageUrl': secondImageUrl,
        // 'thirdImageUrl': thirdImageUrl,
        // "target_age": [ageRangePreference.start, ageRangePreference.end],
        // "photos": [],
        // "target_gender": genderPreferences.toString(),
      });
    } catch (error) {
      rethrow;
    }
  }

  Future<void> getProfilesWhichHaveLikedCurrentUserAPI() async {
    final urlToCallGetProfilesWhichBeenHaveLikedByCurrentUserFromBackend =
        '$url/api/v1/activity/liked_by';
    try {
      final response = await _chuckerHttpClient.get(
          Uri.parse(
              urlToCallGetProfilesWhichBeenHaveLikedByCurrentUserFromBackend),
          headers: {'Authorization': bearerToken});
      final decodedResponseFromBackend = jsonDecode(response.body);
      logger.i("Data of users who liked current user: ${response.body}");

      admirerListOfProfilesForCurrentUser =
          decodedResponseFromBackend['data'] as List;
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  Future<void> getThreadsAPI() async {
    final urlToCallGetThreadsFromBackend = '$url/api/v1/chat/threads';
    try {
      final response = await _chuckerHttpClient.get(
          Uri.parse(urlToCallGetThreadsFromBackend),
          headers: {'Authorization': bearerToken});

      final decodedResponseFromBackend = jsonDecode(response.body);
      final data = decodedResponseFromBackend['data'] as List;
      logger.i("Data of threads: $data");

      threadsListForCurrentUser = data;
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  Future<void> getMessagesAPI(String threadId) async {
    currentThreadId = threadId;
    final urlToCallGetMessagesFromBackend =
        '$url/api/v1/chat?thread_id=$currentThreadId';
    try {
      final response = await _chuckerHttpClient.get(
          Uri.parse(urlToCallGetMessagesFromBackend),
          headers: {'Authorization': bearerToken});

      final decodedResponseFromBackend = jsonDecode(response.body);
      final data = decodedResponseFromBackend['data'] as List;
      logger.i("Data of get message: $data");

      messagesListForCorrespondingThread = data;
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> addMessageAPI(
      String message, int receiverId, String threadId) async {
    final urlToCallAddMessageFromBackend = '$url/api/v1/chat';
    try {
      final response = await _chuckerHttpClient
          .post(Uri.parse(urlToCallAddMessageFromBackend), body: {
        'message': message,
        'receiverId': receiverId.toString(),
        'threadId': threadId
      }, headers: {
        'Authorization': bearerToken
      });
      final decodedResponseFromBackend = jsonDecode(response.body);
      final data = decodedResponseFromBackend['data'] as Map<String, dynamic>;
      logger.i("Data of add message: $data");

      return data;
    } catch (error) {
      rethrow;
    }
  }

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

  Future<Profile> getSingleUserAPI(int userIdToGetProfileOf) async {
    final urlToCallGetSingleUserAPI =
        '$url/api/v1/user?user_id=$userIdToGetProfileOf';
    try {
      final response = await _chuckerHttpClient.get(
          Uri.parse(urlToCallGetSingleUserAPI),
          headers: {'Authorization': bearerToken});
      final decodedResponseFromBackend = jsonDecode(response.body);
      final data = decodedResponseFromBackend['data'] as Profile;
      logger.i("Data of single user: $data");

      return data;
    } catch (error) {
      rethrow;
    }
  }

  Future<void> getStumbleMatchesFromBackend() async {
    final urlToCallGetStumbleMatchesFromBackendAPI =
        '$url/api/v1/activity?status=69';
    try {
      final response = await _chuckerHttpClient.get(
          Uri.parse(urlToCallGetStumbleMatchesFromBackendAPI),
          headers: {'Authorization': bearerToken});
      final decodedResponseFromBackend = jsonDecode(response.body);
      final data = decodedResponseFromBackend['data'] as List;
      logger.i("Data of matches: $data");

      currentListOfMatchesForCurrentUser = data;
      notifyListeners();
      return;
    } catch (error) {
      rethrow;
    }
  }

  Future<void> getProfilesWhoCurrentUserHasLikedAPI() async {
    final urlToCallGetProfilesWhoHaveLikedCurrentUserFromBackendAPI =
        '$url/api/v1/activity?status=1';
    try {
      final response = await _chuckerHttpClient.get(
          Uri.parse(urlToCallGetProfilesWhoHaveLikedCurrentUserFromBackendAPI),
          headers: {'Authorization': bearerToken});
      final decodedResponseFromBackend = jsonDecode(response.body);
      logger.i("Data of profiles liked by user: $decodedResponseFromBackend");

      likedListOfProfilesForCurrentUser =
          decodedResponseFromBackend['data'] as List;
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  Future<void> getPotentialStumblesFromBackend() async {
    final urlToCallGetPotentialStumblesFromBackendAPI =
        '$url/api/v1/activity/find';
    try {
      final response = await _chuckerHttpClient.get(
          Uri.parse(urlToCallGetPotentialStumblesFromBackendAPI),
          headers: {'Authorization': bearerToken});
      final decodedResponseFromBackend = jsonDecode(response.body);
      logger.i("Data of stumbles: $decodedResponseFromBackend");

      currentListOfStumblesForCurrentUser =
          decodedResponseFromBackend['data'] as List<Profile>;
    } catch (error) {
      rethrow;
    }
  }

  Future<void> uploadPhotosAPI(int imageNumber) async {
    final urlToCallUploadPicsAPI = '$url/api/v1/user/upload';

    final File fileToSendToBackend = imageNumber == 1
        ? firstImageUrl
        : imageNumber == 2
            ? secondImageUrl
            : thirdImageUrl;

    try {
      final stream = http.ByteStream(fileToSendToBackend.openRead());
      final length = await fileToSendToBackend.length();
      final request =
          http.MultipartRequest("POST", Uri.parse(urlToCallUploadPicsAPI));
      final multipartFile = http.MultipartFile('file', stream, length,
          filename: basename(fileToSendToBackend.path));
      request.files.add(multipartFile);
      final response = await request.send();
      logger.i(response.statusCode);
      response.stream.transform(utf8.decoder).listen((value) async {
        logger.i(value);
      });
      // final decodedResponseFromBackend = jsonDecode(response.body);
      // logger.i("Data of upload pics: " + decodedResponseFromBackend.toString());
    } catch (error) {
      rethrow;
    }
  }
}
