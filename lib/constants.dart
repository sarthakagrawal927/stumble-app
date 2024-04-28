import 'package:flutter/material.dart';

enum Gender { woman, man, nonBinary }

const authKey = "authToken";

enum ModelOpened { userInterestInfoTeaching }

const Color backgroundColor = Color.fromRGBO(255, 254, 253, 0.9);

const Color widgetColor = Colors.white;

const Color headingColor = Colors.black;

const Color textColor = Colors.black;

const Color dropDownColor = Colors.black;

const Color topAppBarColor = Color.fromRGBO(255, 254, 253, 0.9);

const Color bottomAppBarColor = Colors.black;

const Color filterScreenTextColor = Color.fromRGBO(231, 10, 95, 0.5);

const Color filterScreenHeadingColor = Color.fromRGBO(231, 10, 95, 0.75);

const Color commentIconColorForPhotos = Color.fromRGBO(255, 254, 253, 1);

const Color commentIconColorForOtherPrompts = Colors.black87;

const Color selectedScreenIconColor = Colors.white;

const Color nonSelectedScreenIconColor = Colors.white38;

const whiteColor = Colors.white;

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

const promptExplainingStumblingReason =
    'You both have the same reason for "Stumbling" onto one another!';

const promptExplainingLocationUsage = "";

const double borderRadiusValue = 20;
