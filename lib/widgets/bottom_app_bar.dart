import 'package:dating_made_better/constants.dart';
import 'package:dating_made_better/constants_fonts.dart';
import 'package:dating_made_better/screens/events_screen.dart';
import 'package:dating_made_better/screens/matches_and_chats_screen.dart';
import 'package:dating_made_better/screens/swiping_screen.dart';
import 'package:flutter/material.dart';

import '../screens/user_profile_overview_screen.dart';

Map<BottomBarScreens, BottomBarIcon> bottomScreenNameToIcon = {
  BottomBarScreens.swipingScreen: BottomBarIcon(Icons.favorite, "Stumble!"),
  BottomBarScreens.chatScreen: BottomBarIcon(Icons.chat, "Chats"),
  BottomBarScreens.userProfileOverviewScreen: BottomBarIcon(Icons.account_box_rounded, "Profile"),
  BottomBarScreens.eventsScreen: BottomBarIcon(Icons.groups_3_outlined, "Events"),
};

const bottomScreenNameToRoute = {
  BottomBarScreens.swipingScreen: SwipingScreen.routeName,
  BottomBarScreens.chatScreen: MatchesAndChatsScreen.routeName,
  BottomBarScreens.userProfileOverviewScreen: UserProfileScreen.routeName,
  BottomBarScreens.eventsScreen: EventsScreen.routeName
};

class BottomBarIcon {
  final IconData icon;
  final String iconText;

  BottomBarIcon(this.icon, this.iconText);
}

class BottomBar extends StatelessWidget {
GestureDetector iconButtonBasedOnCurrentScreen(Icon icon, Color color,
      BuildContext context, String routeNameOfScreenToPush, String iconText) {
    return GestureDetector(
      onTap: () {
        if (routeNameOfScreenToPush != "") {
          Navigator.pushReplacementNamed(context, routeNameOfScreenToPush);
        }
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          IconButton(
            icon: icon,
            padding: EdgeInsets.all(0),
            iconSize: fontSize32(context),
            constraints: BoxConstraints(),
            color: color,
            onPressed: () {
              if (routeNameOfScreenToPush != "") {
                Navigator.pushReplacementNamed(context, routeNameOfScreenToPush);
              }
            },
          ),
          Text(
            iconText,
            style: TextStyle(fontSize: fontSize80(context), color: color, height: 0.0),
          ),
        ],
      ),
    );
  }

  Padding bottomAppBarConfigurationBasedOnCurrentScreen(
      BuildContext context, BottomBarScreens currentScreen) {
    return Padding(
      padding: EdgeInsets.zero,
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: BottomBarScreens.values
              .map((value) => iconButtonBasedOnCurrentScreen(
                    Icon(bottomScreenNameToIcon[value]!.icon),
                    currentScreen == value
                        ? selectedScreenIconColor
                        : nonSelectedScreenIconColor,
                    context,
                    currentScreen == value
                        ? ""
                        : bottomScreenNameToRoute[value] ?? "",
                    bottomScreenNameToIcon[value]!.iconText
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
      case BottomBarScreens.eventsScreen:
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
        marginHeight16(context),
      ),
      child: BottomAppBar(
        color: bottomAppBarColor,
        height: marginHeight16(context) * 1.5,
        child: returnWidgetBasedOnCurrentScreen(context),
      ),
    );
  }
}
