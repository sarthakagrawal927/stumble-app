import 'package:flutter/material.dart';

class FirstScreenStateProviders extends ChangeNotifier {
  bool isUseMobileNumberButtonClicked = false;
  bool isOTPSubmitted = false;
  bool isNameSubmitted = false;
  bool isAgeSubmitted = false;
  bool isGenderSubmitted = false;
  bool isFirstPhotoSubmitted = false;
  bool isPromptSubmitted = false;

  bool get getUseMobileNumberButtonClickedValue {
    return isUseMobileNumberButtonClicked;
  }

  set setUseMobileNumberButtonClickedValue(bool value) {
    isUseMobileNumberButtonClicked = value;
    notifyListeners();
  }

  bool get getisOTPSubmittedValue {
    return isOTPSubmitted;
  }

  set setisOTPSubmittedValue(bool value) {
    isOTPSubmitted = value;
    notifyListeners();
  }

  bool get getisNameSubmittedValue {
    return isNameSubmitted;
  }

  set setisNameSubmittedValue(bool value) {
    isNameSubmitted = value;
    notifyListeners();
  }

  bool get getisAgeSubmittedValue {
    return isAgeSubmitted;
  }

  set setisAgeSubmittedValue(bool value) {
    isAgeSubmitted = value;
    notifyListeners();
  }

  bool get getisGenderSubmittedValue {
    return isGenderSubmitted;
  }

  set setisGenderSubmittedValue(bool value) {
    isGenderSubmitted = value;
    notifyListeners();
  }

  bool get getisFirstPhotoSubmittedValue {
    return isFirstPhotoSubmitted;
  }

  set setisFirstPhotoSubmittedValue(bool value) {
    isFirstPhotoSubmitted = value;
    notifyListeners();
  }

  bool get getisPromptSubmittedValue {
    return isPromptSubmitted;
  }

  set setisPromptSubmittedValue(bool value) {
    isPromptSubmitted = value;
    notifyListeners();
  }
}
