import 'package:dating_made_better/global_store.dart';
import 'package:dating_made_better/providers/first_screen_state_providers.dart';
import 'package:dating_made_better/providers/profile.dart';
import 'package:dating_made_better/screens/swiping_screen.dart';
import 'package:dating_made_better/utils/helper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void handleSignInComplete(BuildContext context) {
  ScreenMode screenMode = getScreenMode();
  if (AppConstants.token.isNotEmpty) {
    Provider.of<FirstScreenStateProviders>(context, listen: false)
        .setActiveScreenMode(screenMode);
    Provider.of<Profile>(context, listen: false).setEntireProfileForEdit();
    if (screenMode == ScreenMode.swipingScreen) {
      // redirect to swiping screen
      Navigator.of(context).pushReplacementNamed(SwipingScreen.routeName);
    }
  }
}
