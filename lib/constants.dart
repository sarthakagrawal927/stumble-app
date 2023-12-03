import 'package:flutter/material.dart';

enum Gender { woman, man, nonBinary }

const authKey = "authToken";

enum ModelOpened { userInterestInfoTeaching }

const Color backgroundColor = Color.fromRGBO(26, 26, 26, 1);

const Color widgetColor = Color.fromRGBO(26, 26, 26, 1);

const Color headingColor = Color.fromRGBO(255, 254, 253, 1);

const Color topAppBarColor = Colors.black54;

const Color bottomAppBarColor = Colors.black54;

const Color filterScreenTextColor = Color.fromRGBO(231, 10, 95, 0.5);

const Color filterScreenHeadingColor = Color.fromRGBO(231, 10, 95, 0.75);

const whiteColor = Color.fromRGBO(255, 254, 253, 1);

enum ActivityType { like, dislike, match, unmatch }

enum InterestType { hookup, relationship, friendship }

const activityValue = {
  ActivityType.like: 1,
  ActivityType.dislike: -1,
  ActivityType.match: 69,
  ActivityType.unmatch: 96,
};

const interestValue = {
  InterestType.hookup: 1,
  InterestType.relationship: 2,
  InterestType.friendship: 3,
};

enum BottomBarScreens {
  userProfileOverviewScreen,
  swipingScreen,
  chatScreen,
}

enum PhotoUploaderMode { singleUpload, multiUpload }

const defaultBackupImage =
    "https://t4.ftcdn.net/jpg/02/24/86/95/360_F_224869519_aRaeLneqALfPNBzg0xxMZXghtvBXkfIA.jpg";
