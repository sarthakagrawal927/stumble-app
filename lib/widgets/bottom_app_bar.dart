import 'package:dating_made_better/constants.dart';
import 'package:dating_made_better/screens/matches_and_chats_screen.dart';
import 'package:dating_made_better/screens/swiping_screen.dart';
import 'package:flutter/material.dart';

import '../screens/user_profile_overview_screen.dart';

const bottomScreenNameToIcon = {
  BottomBarScreens.swipingScreen: Icons.favorite,
  BottomBarScreens.chatScreen: Icons.chat,
  BottomBarScreens.userProfileOverviewScreen: Icons.account_box_rounded,
};

const bottomScreenNameToRoute = {
  BottomBarScreens.swipingScreen: SwipingScreen.routeName,
  BottomBarScreens.chatScreen: MatchesAndChatsScreen.routeName,
  BottomBarScreens.userProfileOverviewScreen: UserProfileScreen.routeName,
};

class BottomBar extends StatelessWidget {
  IconButton iconButtonBasedOnCurrentScreen(Icon icon, Color color,
      BuildContext context, String routeNameOfScreenToPush) {
    return IconButton(
      icon: icon,
      color: color,
      onPressed: () {
        if (routeNameOfScreenToPush != "") {
          Navigator.pushReplacementNamed(context, routeNameOfScreenToPush);
        }
      },
    );
  }

  Padding bottomAppBarConfigurationBasedOnCurrentScreen(
      BuildContext context, BottomBarScreens currentScreen) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: BottomBarScreens.values
              .map((value) => iconButtonBasedOnCurrentScreen(
                    Icon(bottomScreenNameToIcon[value]),
                    currentScreen == value ? Colors.red : whiteColor,
                    context,
                    currentScreen == value
                        ? ""
                        : bottomScreenNameToRoute[value] ?? "",
                  ))
              .toList()),
    );
  }

  final BottomBarScreens currentScreen;
  const BottomBar({required this.currentScreen, super.key});

  Widget returnWidgetBasedOnCurrentScreen(BuildContext context) {
    Widget widgetToReturn;
    switch (currentScreen) {
      case BottomBarScreens.userProfileOverviewScreen:
      case BottomBarScreens.chatScreen:
        widgetToReturn = bottomAppBarConfigurationBasedOnCurrentScreen(
            context, currentScreen);
        break;
      case BottomBarScreens.swipingScreen:
      default:
        widgetToReturn = bottomAppBarConfigurationBasedOnCurrentScreen(
            context, BottomBarScreens.swipingScreen);
        break;
    }
    return widgetToReturn;
  }

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(
        MediaQuery.of(context).size.height / 16,
      ),
      child: BottomAppBar(
        color: bottomAppBarColor,
        child: returnWidgetBasedOnCurrentScreen(context),
      ),
    );
  }
}
