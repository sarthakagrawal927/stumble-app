import 'package:dating_made_better/screens/chat_screen.dart';
import 'package:dating_made_better/screens/swiping_screen.dart';
import 'package:flutter/material.dart';

import '../screens/user_profile_overview_screen.dart';

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
      BuildContext context, String currentScreen) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          iconButtonBasedOnCurrentScreen(
            const Icon(Icons.account_box_rounded),
            currentScreen == "UserProfileOverviewScreen"
                ? Colors.red
                : Colors.grey.shade500,
            context,
            currentScreen == "UserProfileOverviewScreen"
                ? ""
                : UserProfileScreen.routeName,
          ),
          iconButtonBasedOnCurrentScreen(
            const Icon(Icons.favorite),
            currentScreen == "SwipingScreen"
                ? Colors.red
                : Colors.grey.shade500,
            context,
            currentScreen == "SwipingScreen" ? "" : SwipingScreen.routeName,
          ),
          iconButtonBasedOnCurrentScreen(
            const Icon(Icons.chat_bubble_rounded),
            currentScreen == "ChatScreen" ? Colors.red : Colors.grey.shade500,
            context,
            currentScreen == "ChatScreen" ? "" : ChatScreen.routeName,
          ),
        ],
      ),
    );
  }

  final String currentScreen;
  const BottomBar({required this.currentScreen});

  Widget returnWidgetBasedOnCurrentScreen(BuildContext context) {
    Widget widgetToReturn;
    switch (currentScreen) {
      case "UserProfileOverviewScreen":
        widgetToReturn = bottomAppBarConfigurationBasedOnCurrentScreen(
            context, "UserProfileOverviewScreen");
        break;
      case "ChatScreen":
        widgetToReturn = bottomAppBarConfigurationBasedOnCurrentScreen(
            context, "ChatScreen");
        break;
      default:
        widgetToReturn = bottomAppBarConfigurationBasedOnCurrentScreen(
            context, "SwipingScreen");
        break;
    }
    return widgetToReturn;
  }

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: Theme.of(context).bottomAppBarColor,
      child: returnWidgetBasedOnCurrentScreen(context),
    );
  }
}
