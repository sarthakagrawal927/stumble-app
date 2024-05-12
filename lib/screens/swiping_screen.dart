import 'package:dating_made_better/stumbles_list_constants.dart';
import 'package:dating_made_better/utils/call_api.dart';
import 'package:dating_made_better/utils/inherited_keys_helper.dart';
import 'package:dating_made_better/widgets/location.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:dating_made_better/utils/internal_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:showcaseview/showcaseview.dart';

import '../constants.dart';
import '../providers/profile.dart';
import '../widgets/bottom_app_bar.dart';
import '../widgets/cards_stack_widget.dart';

class SwipingScreen extends StatefulWidget {
  static const routeName = '/swiping-screen';

  const SwipingScreen({super.key});

  @override
  State<SwipingScreen> createState() => _SwipingScreenState();
}

// save the token below to the database
Future<void> saveTokenToDatabase(String token) async {
  writeSecureData('fb_token', token);
  await addDevice(token);
}

class _SwipingScreenState extends State<SwipingScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  final GlobalKey _locationUsageKey = GlobalKey();
  final GlobalKey _dropDownKey = GlobalKey();
  final GlobalKey _profileLikeKey = GlobalKey();
  final GlobalKey _profileDislikeKey = GlobalKey();

  void setupPushNotifications() async {
    final isNotificationSetForDevice = await readSecureData(
      'fb_token',
    );

    final fcm = FirebaseMessaging.instance;

    await fcm.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if (isNotificationSetForDevice == null ||
        isNotificationSetForDevice == '') {
      final token = await fcm.getToken();
      if (token!.isEmpty) return;
      await saveTokenToDatabase(token);
    }
    FirebaseMessaging.instance.onTokenRefresh.listen(saveTokenToDatabase);
  }

  displayInitialPrompts() async {
    SharedPreferences sharedPreferencesObject =
        await SharedPreferences.getInstance();
    bool? initialPromptsVisibilityStatus =
        sharedPreferencesObject.getBool("displayInitialPrompts");

    if (initialPromptsVisibilityStatus == null) {
      sharedPreferencesObject.setBool("displayInitialPrompts", true);
      return true;
    }
    return false;
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      setupPushNotifications();
      Provider.of<Profile>(context, listen: false).setEntireProfileForEdit();
    });
    try {
      displayInitialPrompts().then((status) => {
            if (status)
              {
                WidgetsBinding.instance.addPostFrameCallback((_) async {
                  ShowCaseWidget.of(context).startShowCase(
                    [
                      _locationUsageKey,
                      _dropDownKey,
                      _profileLikeKey,
                      _profileDislikeKey,
                    ],
                  );
                }),
              }
          });
    } catch (err) {}
  }

  @override
  Widget build(BuildContext context) {
    return InheritedKeysHelper(
      locationUsageKey: _locationUsageKey,
      dropDownKey: _dropDownKey,
      profileDislikeKey: _profileDislikeKey,
      profileLikeKey: _profileLikeKey,
      child: Scaffold(
        backgroundColor: backgroundColor,
        key: _scaffoldKey,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(
            marginHeight16(context),
          ),
          child: AppBar(
            automaticallyImplyLeading: false,
            actions: [
              DropdownButtonHideUnderline(
                child: DropdownButton(
                  iconSize: marginWidth16(context),
                  dropdownColor: dropDownColor,
                  items: dropDownOptionList
                      .map((e) => DropdownMenuItem(
                            alignment: Alignment.center,
                            value: e!.value,
                            child: Row(
                              children: [
                                e.icon,
                                const SizedBox(width: 8),
                                Text(
                                  e.label,
                                  style: const TextStyle(
                                    color: whiteColor,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ))
                      .toList(),
                  onChanged: (itemIdentifier) async {
                    dropDownOptions[itemIdentifier]!.getActivities().then(
                          (value) => Navigator.pushNamed(context,
                              dropDownOptions[itemIdentifier]!.routeName,
                              arguments: value),
                        );
                  },
                  icon: Padding(
                    padding: EdgeInsets.only(right: marginWidth16(context)),
                    child: Showcase(
                      description: "You can find your stumbler lists here!",
                      key: _dropDownKey,
                      blurValue: 5,
                      descriptionPadding:
                          EdgeInsets.all(marginWidth128(context)),
                      overlayOpacity: 0.1,
                      showArrow: true,
                      targetPadding: EdgeInsets.all(marginWidth128(context)),
                      child: const Icon(
                        Icons.menu,
                        color: headingColor,
                      ),
                    ),
                  ),
                ),
              ),
            ],
            backgroundColor: topAppBarColor,
            title: Padding(
              padding: EdgeInsets.only(left: marginWidth16(context)),
              child: Showcase(
                description: promptExplainingLocationUsage,
                descTextStyle: TextStyle(fontSize: marginWidth24(context)),
                key: _locationUsageKey,
                blurValue: 5,
                descriptionPadding: EdgeInsets.symmetric(
                  vertical: MediaQuery.of(context).size.height / 128,
                  horizontal: marginWidth128(context),
                ),
                tooltipPosition: TooltipPosition.bottom,
                overlayOpacity: 0.5,
                showArrow: false,
                targetPadding: EdgeInsets.all(marginWidth32(context)),
                child: Text(
                  textAlign: TextAlign.center,
                  'Stumble!',
                  style: GoogleFonts.sacramento(
                    fontSize: MediaQuery.of(context).size.width / 13,
                    color: headingColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            centerTitle: false,
          ),
        ),
        body: Stack(
          alignment: AlignmentDirectional.topCenter,
          children: [
            CardsStackWidget(),
            const MyLocationComponent(),
          ],
        ),
        bottomNavigationBar:
            const BottomBar(currentScreen: BottomBarScreens.swipingScreen),
      ),
    );
  }
}
