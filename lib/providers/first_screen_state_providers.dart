import 'package:flutter/material.dart';

enum ScreenMode {
  landing,
  phoneNumberInput,
  otpInput,
  nameInput,
  ageInput,
  genderInput,
  photoAdditionInput,
  promptAdditionInput,
  swipingScreen
}

class FirstScreenStateProviders extends ChangeNotifier {
  static var activeScreenMode = ScreenMode.landing;
  FirstScreenStateProviders(ScreenMode fromParentActiveScreenMode) {
    activeScreenMode = fromParentActiveScreenMode;
  }

  setNextScreenActive() {
    activeScreenMode = ScreenMode.values[activeScreenMode.index + 1];
    notifyListeners();
  }

  ScreenMode get getActiveScreenModeValue {
    return activeScreenMode;
  }
}
