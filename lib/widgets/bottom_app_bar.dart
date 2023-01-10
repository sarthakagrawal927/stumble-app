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

  final String currentScreen;
  BottomBar({required this.currentScreen});
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 20.0),
        child: currentScreen == "SwipingScreen"
            ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  iconButtonBasedOnCurrentScreen(
                    Icon(Icons.account_box_rounded),
                    Colors.grey,
                    context,
                    UserProfileScreen.routeName,
                  ),
                  iconButtonBasedOnCurrentScreen(
                    Icon(Icons.favorite),
                    Colors.amber,
                    context,
                    "",
                  ),
                ],
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  iconButtonBasedOnCurrentScreen(
                    Icon(Icons.account_box_rounded),
                    Colors.amber,
                    context,
                    "",
                  ),
                  iconButtonBasedOnCurrentScreen(
                    Icon(Icons.favorite),
                    Colors.grey,
                    context,
                    SwipingScreen.routeName,
                  ),
                ],
              ),
      ),
    );
  }
}
