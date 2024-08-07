import 'package:dating_made_better/constants.dart';
import 'package:dating_made_better/constants_fonts.dart';
import 'package:dating_made_better/screens/events_screen.dart';
import 'package:dating_made_better/screens/matches_and_chats_screen.dart';
import 'package:dating_made_better/screens/swiping_screen.dart';
import 'package:flutter/material.dart';

import '../screens/user_profile_overview_screen.dart';

const bottomScreenNameToIcon = {
  BottomBarScreens.swipingScreen: Icons.favorite,
  BottomBarScreens.chatScreen: Icons.chat,
  BottomBarScreens.userProfileOverviewScreen: Icons.account_box_rounded,
  BottomBarScreens.eventsScreen: Icons.groups_3_outlined
};

const bottomScreenNameToRoute = {
  BottomBarScreens.swipingScreen: SwipingScreen.routeName,
  BottomBarScreens.chatScreen: MatchesAndChatsScreen.routeName,
  BottomBarScreens.userProfileOverviewScreen: UserProfileScreen.routeName,
  BottomBarScreens.eventsScreen: EventsScreen.routeName
};

class BottomBar extends StatelessWidget {
  IconButton iconButtonBasedOnCurrentScreen(Icon icon, Color color,
      BuildContext context, String routeNameOfScreenToPush) {
    return IconButton(
      icon: icon,
      iconSize: fontSize32(context),
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
      padding: EdgeInsets.only(bottom: marginHeight128(context)),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: BottomBarScreens.values
              .map((value) => iconButtonBasedOnCurrentScreen(
                    Icon(bottomScreenNameToIcon[value]),
                    currentScreen == value
                        ? selectedScreenIconColor
                        : nonSelectedScreenIconColor,
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
        child: returnWidgetBasedOnCurrentScreen(context),
      ),
    );
  }
}
