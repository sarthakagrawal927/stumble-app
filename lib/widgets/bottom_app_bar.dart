import 'package:dating_made_better/constants.dart';
import 'package:dating_made_better/constants_fonts.dart';
import 'package:dating_made_better/providers/socket.dart';
import 'package:dating_made_better/screens/matches_and_chats_screen.dart';
import 'package:dating_made_better/screens/swiping_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
  Widget iconButtonBasedOnCurrentScreen(Icon icon, Color color,
      BuildContext context, String routeNameOfScreenToPush) {
    return Stack(
      children: [
        IconButton(
          icon: icon,
          iconSize: fontSize32(context),
          color: color,
          onPressed: () {
            if (routeNameOfScreenToPush != "") {
              Navigator.pushReplacementNamed(context, routeNameOfScreenToPush);
            }
          },
        ),
        if (routeNameOfScreenToPush == MatchesAndChatsScreen.routeName)
          Positioned(
            top: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.all(2),
              decoration: const BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
              ),
              constraints: const BoxConstraints(
                minWidth: 16,
                minHeight: 16,
              ),
              child: Text(
                Provider.of<SocketProvider>(context).newMessageCount.toString(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
      ],
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
