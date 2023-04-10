import 'package:flutter/material.dart';

class FirstScreenStateProviders extends ChangeNotifier {
  bool isUseMobileNumberButtonClicked = false;
  bool isOTPSubmitted = false;
  bool isNameSubmitted = false;
  bool isGenderSubmitted = false;

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

  bool get getisGenderSubmittedValue {
    return isGenderSubmitted;
  }

  set setisGenderSubmittedValue(bool value) {
    isGenderSubmitted = value;
    notifyListeners();
  }
}
