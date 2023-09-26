import 'package:flutter/material.dart';

enum Gender { woman, man, nonBinary }

enum Swipe { left, right, none }

enum SwipeType { swipe, comment, nicheSelection }

const authKey = "authToken";

const Color backgroundColor = Color.fromRGBO(26, 26, 26, 0.75);

const Color widgetColor = Color.fromRGBO(26, 26, 26, 1);

const Color headingColor = Color.fromRGBO(255, 254, 253, 1);

const Color topAppBarColor = Color.fromRGBO(26, 26, 26, 0.5);

const Color bottomAppBarColor = Color.fromRGBO(26, 26, 26, 1);

const Color filterScreenTextColor = Color.fromRGBO(231, 10, 95, 0.5);

const Color filterScreenHeadingColor = Color.fromRGBO(231, 10, 95, 0.75);

const whiteColor = Color.fromRGBO(255, 254, 253, 1);

enum ActivityType { like, dislike, match, unmatch }

const activityValue = {
  ActivityType.like: 1,
  ActivityType.dislike: -1,
  ActivityType.match: 69,
  ActivityType.unmatch: 96,
};

const defaultBackupImage =
    "https://t4.ftcdn.net/jpg/02/24/86/95/360_F_224869519_aRaeLneqALfPNBzg0xxMZXghtvBXkfIA.jpg";
