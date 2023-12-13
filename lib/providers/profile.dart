import 'dart:io';

import 'package:dating_made_better/global_store.dart';
import 'package:dating_made_better/utils/call_api.dart';
import 'package:dating_made_better/utils/internal_storage.dart';
import 'package:flutter/material.dart';
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
  bool isPlatonic;
  RangeValues ageRangePreference;
  List<Gender> genderPreferences;
  String bearerToken = AppConstants.token;
  double profileCompletionAmount = 0.0;
  String badgeLabel = "";

  // https://stackoverflow.com/questions/67126549/flutter-define-default-value-of-a-datetime-in-constructor
  Profile({
    required this.id,
    required this.name,
    this.phoneNumber = "",
    required this.gender,
    this.age = 23,
    DateTime? birthDate,
    required this.photos,
    this.photoVerified = true,
    this.conversationStarter = "Hi there, I am on Stumble!",
    this.isPlatonic = false,
    this.ageRangePreference = const RangeValues(18, 50),
    this.genderPreferences = const [Gender.man, Gender.nonBinary, Gender.woman],
    this.badgeLabel = "",
  }) : birthDate = birthDate ?? DateTime.now();

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

  set setIfUserIsPlatonic(bool isPlatonic) {
    isPlatonic = isPlatonic;
    notifyListeners();
  }

  set setConversationStarter(String conversationStarterPromptInput) {
    conversationStarter = conversationStarterPromptInput;
    profileCompletionAmount += 1;
    notifyListeners();
  }

  setImageAtPosition(File image, [int position = 1]) {
    if (photos.length < position) {
      photos.add(image);
      profileCompletionAmount += 1;
    } else {
      var idx = position - 1;
      photos[idx] = image;
    }
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

  String get getBadgeLabel {
    return badgeLabel;
  }

  String get getPhone {
    return phoneNumber;
  }

  bool get getPhotoVerificationStatus {
    return photoVerified;
  }

  bool get getIfUserIsPlatonic {
    return isPlatonic;
  }

  List<File> get getPhotos {
    return photos;
  }

  DateTime get getBirthDate {
    return birthDate;
  }

  File getImageAtPos(int position) {
    return isImageAtPosPresent(position)
        ? photos[position - 1]
        : File(defaultBackupImage);
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

  // 1,2,3
  bool isImageAtPosPresent(int position) {
    return photos.length >= position && photos[position - 1] != File("");
  }

  setEntireProfileForEdit({Profile? profile}) {
    Profile fromConstants = profile ?? Profile.fromJson(AppConstants.user);
    name = fromConstants.name;
    gender = fromConstants.gender;
    birthDate = fromConstants.birthDate;
    conversationStarter = fromConstants.conversationStarter;
    photos = fromConstants.photos;
    photoVerified = fromConstants.photoVerified;
    age = fromConstants.age;
    phoneNumber = fromConstants.phoneNumber;
    isPlatonic = fromConstants.isPlatonic;
    profileCompletionAmount =
        photos.length * 1.0 + conversationStarter.length > 0 ? 1.0 : 0.0;
    genderPreferences = fromConstants.genderPreferences;
    ageRangePreference = fromConstants.ageRangePreference;
    notifyListeners();
  }

  Future<Profile> upsertUser(Map<String, dynamic> bodyParams) async {
    try {
      Profile userProfile = await upsertUserApi(bodyParams);
      setEntireProfileForEdit(profile: userProfile);
      return userProfile;
    } catch (e) {
      // clear authToken
      await deleteSecureData(authKey);
      logger.e(e);
      rethrow;
    }
  }

  Future<Profile> upsertUserOnboarding() async {
    return upsertUser({
      "name": name,
      "gender": gender.index,
      "dob": birthDate.toIso8601String(),
      "conversation_starter": conversationStarter,
      "photos": photos.map((e) => e.path).toList(),
      "is_platonic": isPlatonic,
    });
  }

  static fromJson(profile) {
    List<dynamic> photoList = (profile[profileDBKeys[ProfileKeys.photos]] ?? [])
        .where((element) => element is String)
        .map((element) => element.toString())
        .toList();
    List<File> photoFileList =
        photoList.map((e) => File(e.toString())).toList();

    List<dynamic> targetAgeListDynamic =
        profile[profileDBKeys[ProfileKeys.targetAge]] ?? [18, 30];
    RangeValues targetAgeList =
        convertRangeValuesToInt(targetAgeListDynamic.cast<int>());

    List<dynamic> targetGenderListDynamic =
        profile[profileDBKeys[ProfileKeys.targetGender]] ??
            [Gender.woman.index, Gender.man.index];
    List<Gender> targetGenderList =
        convertIntListToEnumList(targetGenderListDynamic.cast<int>());

    return Profile(
      id: profile[profileDBKeys[ProfileKeys.id]],
      name: profile[profileDBKeys[ProfileKeys.name]] ?? "",
      gender: Gender.values[
          profile[profileDBKeys[ProfileKeys.gender]] ?? Gender.woman.index],
      conversationStarter:
          profile[profileDBKeys[ProfileKeys.conversationStarter]] ?? "",
      photoVerified: profile[profileDBKeys[ProfileKeys.photoVerified]] ?? false,
      photos: photoFileList,
      age: profile[profileDBKeys[ProfileKeys.age]] ?? 23,
      ageRangePreference: targetAgeList,
      genderPreferences: targetGenderList,
      birthDate: profile[profileDBKeys[ProfileKeys.dob]] != null
          ? DateTime.parse(profile[profileDBKeys[ProfileKeys.dob]])
          : DateTime.now(),
      badgeLabel: profile[profileDBKeys[ProfileKeys.badgeLabel]] ?? "",
    );
  }
}

// {"id":1,"name":"wqdqwdw","phone":"+919792972971","dob":"2010-10-05T00:00:00.000Z","gender":1,"photos":["https://stumblers.s3.ap-south-1.amazonaws.com/uploads/Screenshot_20230926-165250.png"],"role":11,"phone_verified":true,"photo_verified":false,"conversation_starter":"dqwdwqdwqdwq","target_age":[],"target_gender":[1,2],"instagram_id":null,"snapchat_id":null,"twitter_id":null,"height":22,"interests":["dance","music","sports"],"voice_note":null,"workDesignation":"Software Engineer","workPlace":"Bangalore","education":"B.Tech","educationCompletionYear":2022,"languages":["english","hindi"],"religion":"hindu","createdAt":"2023-09-19T15:08:42.356Z","updatedAt":"2023-10-03T16:04:38.666Z"}}
enum ProfileKeys {
  id,
  name,
  phone,
  age,
  dob,
  gender,
  photos,
  role,
  phoneVerified,
  photoVerified,
  conversationStarter,
  targetAge,
  targetGender,
  instagramId,
  snapchatId,
  twitterId,
  height,
  interests,
  voiceNote,
  workDesignation,
  workPlace,
  education,
  educationCompletionYear,
  languages,
  religion,
  badgeLabel,
}

const profileDBKeys = {
  ProfileKeys.id: "id",
  ProfileKeys.name: "name",
  ProfileKeys.phone: "phone",
  ProfileKeys.dob: "dob",
  ProfileKeys.gender: "gender",
  ProfileKeys.photos: "photos",
  ProfileKeys.role: "role",
  ProfileKeys.phoneVerified: "phone_verified",
  ProfileKeys.photoVerified: "photo_verified",
  ProfileKeys.conversationStarter: "conversation_starter",
  ProfileKeys.targetAge: "target_age",
  ProfileKeys.targetGender: "target_gender",
  ProfileKeys.badgeLabel: "badge_label",
};

RangeValues convertRangeValuesToInt(List<int>? intList) {
  if (intList == null || intList.isEmpty) return const RangeValues(18, 30);
  return RangeValues(intList[0].toDouble(), intList[1].toDouble());
}

List<Gender> convertIntListToEnumList(List<int>? intList) {
  if (intList == null || intList.isEmpty) return [Gender.man, Gender.woman];
  return intList.map((int value) {
    switch (value) {
      case 0:
        return Gender.woman;
      case 1:
        return Gender.man;
      case 2:
        return Gender.nonBinary;
      default:
        throw ArgumentError('Invalid integer value: $value');
    }
  }).toList();
}
