import 'package:dating_made_better/constants.dart';
import 'package:dating_made_better/global_store.dart';
import 'package:dating_made_better/providers/first_screen_state_providers.dart';
import 'package:dating_made_better/screens/login_or_signup_screen.dart';
import 'package:dating_made_better/utils/general.dart';
import 'package:dating_made_better/utils/internal_storage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

ScreenMode getScreenMode() {
  bool userIsEmpty = isNullEmptyOrFalse(AppConstants.user);
  if (userIsEmpty) {
    return ScreenMode.landing;
  } else if (isNullEmptyOrFalse(AppConstants.user["name"])) {
    return ScreenMode.nameInput;
  } else if (isNullEmptyOrFalse(AppConstants.user["dob"])) {
    return ScreenMode.ageInput;
  } else if (isNullEmptyOrFalse(AppConstants.user['gender'])) {
    return ScreenMode.genderInput;
  } else if (isNullEmptyOrFalse(AppConstants.user['photos'])) {
    return ScreenMode.photoAdditionInput;
  } else if (isNullEmptyOrFalse(AppConstants.user['conversation_starter'])) {
    return ScreenMode.promptAdditionInput;
  } else {
    return ScreenMode.swipingScreen;
  }
}

Future<void> logOut(BuildContext context) async {
  AppConstants.token = "";
  AppConstants.user = {};
  deleteSecureData(authKey).then((value) => {
        Provider.of<FirstScreenStateProviders>(context, listen: false)
            .setActiveScreenMode(ScreenMode.landing),
        Navigator.pushNamed(context, AuthScreen.routeName)
      });
}
