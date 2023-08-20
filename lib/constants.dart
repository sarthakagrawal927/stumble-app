import 'package:flutter/material.dart';

enum Gender { woman, man, nonBinary }

enum Swipe { left, right, none }

enum SwipeType { swipe, comment, nicheSelection }

const authKey = "authToken";

const Color backgroundColor = Color.fromRGBO(102, 52, 127, 1);

const Color widgetColor = Color.fromRGBO(158, 71, 132, 1);

const Color headingColor = Color.fromRGBO(231, 10, 95, 1);

const Color topAppBarColor = Color.fromRGBO(55, 48, 107, 1);

const Color bottomAppBarColor = Color.fromRGBO(210, 118, 133, 1);

const whiteColor = Color.fromRGBO(237, 237, 237, 1);

enum ActivityType { like, dislike, match, unmatch }

const activityValue = {
  ActivityType.like: 1,
  ActivityType.dislike: -1,
  ActivityType.match: 69,
  ActivityType.unmatch: 96,
};

const defaultBackupImage =
    "https://t4.ftcdn.net/jpg/02/24/86/95/360_F_224869519_aRaeLneqALfPNBzg0xxMZXghtvBXkfIA.jpg";
