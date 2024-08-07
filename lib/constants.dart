import 'package:flutter/material.dart';

enum Gender { woman, man, nonBinary }

const authKey = "authToken";
const privacyUrl = "https://www.getstumble.app/privacy";

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

enum ActivityType { like, dislike, match, unmatch, report }

enum PhotoVerificationStatus { needToVerify, verified, pending, rejected }

const activityValue = {
  ActivityType.like: 1,
  ActivityType.dislike: -1,
  ActivityType.match: 69,
  ActivityType.unmatch: 96,
};

const photoVerificationStatusValue = {
  PhotoVerificationStatus.needToVerify: 0,
  PhotoVerificationStatus.pending: 1,
  PhotoVerificationStatus.verified: 5,
  PhotoVerificationStatus.rejected: 9,
};

const reportSourceChat = 1;
const reportSourceProfile = 2;
const badActorIdKey = "badActorId";
const reportSourceKey = "source";

enum BottomBarScreens {
  userProfileOverviewScreen,
  swipingScreen,
  chatScreen,
  eventsScreen,
}

enum PromptEnum {
  noMatches,
  noLiked,
  noStumbledOntoMe,
  noStumblersNearby,
  noEvents,
}

Map<PromptEnum, String> getPromptTexts = {
  PromptEnum.noMatches: "You haven't 'Stumbled' into anyone yet; keep swiping!",
  PromptEnum.noLiked: "No nearby stumblers to 'stumble' upon at the moment.",
  PromptEnum.noStumbledOntoMe:
      "No nearby stumblers to 'stumble' upon at the moment.",
  PromptEnum.noStumblersNearby:
      "No nearby stumblers to 'stumble' upon at the moment.",
  PromptEnum.noEvents: "Stay tuned, new events around you can pop up any time!"
};

enum PhotoUploaderMode { singleUpload, multiUpload }

const defaultBackupImage =
    "https://t4.ftcdn.net/jpg/02/24/86/95/360_F_224869519_aRaeLneqALfPNBzg0xxMZXghtvBXkfIA.jpg";

const promptExplainingStumblingReason =
    'You both have the same reason for "Stumbling" onto one another!';

const promptExplainingLocationUsage =
    "Team Stumble will only use your location to ensure that we accurately show you potential stumblers nearby, all to enhance your stumbling experience and provide you with the best possible support!";

const promptExplainingPhotoUnderVerification =
    "Your photo has been submitted; until then, keep Stumbling!";

const double borderRadiusValue = 10;

double marginWidth128(BuildContext context) {
  return MediaQuery.of(context).size.width / 128;
}

double marginWidth64(BuildContext context) {
  return MediaQuery.of(context).size.width / 64;
}

double marginWidth32(BuildContext context) {
  return MediaQuery.of(context).size.width / 32;
}

double marginWidth24(BuildContext context) {
  return MediaQuery.of(context).size.width / 24;
}

double marginWidth16(BuildContext context) {
  return MediaQuery.of(context).size.width / 16;
}

double marginWidth12(BuildContext context) {
  return MediaQuery.of(context).size.width / 12;
}

double marginWidth8(BuildContext context) {
  return MediaQuery.of(context).size.width / 8;
}

double marginWidth4(BuildContext context) {
  return MediaQuery.of(context).size.width / 4;
}

double marginHeight128(BuildContext context) {
  return MediaQuery.of(context).size.height / 128;
}

double marginHeight64(BuildContext context) {
  return MediaQuery.of(context).size.height / 64;
}

double marginHeight48(BuildContext context) {
  return MediaQuery.of(context).size.height / 48;
}

double marginHeight32(BuildContext context) {
  return MediaQuery.of(context).size.height / 32;
}

double marginHeight24(BuildContext context) {
  return MediaQuery.of(context).size.height / 24;
}

double marginHeight16(BuildContext context) {
  return MediaQuery.of(context).size.height / 16;
}

double marginHeight8(BuildContext context) {
  return MediaQuery.of(context).size.height / 8;
}

double marginHeight4(BuildContext context) {
  return MediaQuery.of(context).size.height / 4;
}

double marginHeight2(BuildContext context) {
  return MediaQuery.of(context).size.height / 2;
}
