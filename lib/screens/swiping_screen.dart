import 'package:dating_made_better/stumbles_list_constants.dart';
import 'package:dating_made_better/widgets/location.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:dating_made_better/utils/internal_storage.dart';

import '../constants.dart';
import '../providers/profile.dart';
import '../widgets/bottom_app_bar.dart';
import '../widgets/cards_stack_widget.dart';
import '../widgets/swipe_screen_background.dart';

class SwipingScreen extends StatefulWidget {
  static const routeName = '/swiping-screen';

  const SwipingScreen({super.key});

  @override
  State<SwipingScreen> createState() => _SwipingScreenState();
}

// save the token below to the database
Future<void> saveTokenToDatabase(String? token, [String? apnsToken]) async {
  writeSecureData('fb_token', token ?? '');
  writeSecureData('apns_token', apnsToken ?? '');
}

class _SwipingScreenState extends State<SwipingScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

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

    if (isNotificationSetForDevice == '') {
      final token = await fcm.getToken();
      String? apnsToken;
      if (defaultTargetPlatform == TargetPlatform.iOS) {
        apnsToken = await FirebaseMessaging.instance.getAPNSToken();
      }
      await saveTokenToDatabase(token, apnsToken);
    }
    FirebaseMessaging.instance.onTokenRefresh.listen(saveTokenToDatabase);
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      setupPushNotifications();
      Provider.of<Profile>(context, listen: false).setEntireProfileForEdit();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widgetColor,
      key: _scaffoldKey,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(
          MediaQuery.of(context).size.height / 16,
        ),
        child: AppBar(
            actions: [
              DropdownButtonHideUnderline(
                child: DropdownButton(
                  iconSize: MediaQuery.of(context).size.width / 16,
                  dropdownColor: topAppBarColor,
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
                  icon: const Icon(
                    Icons.menu,
                    color: headingColor,
                  ),
                ),
              ),
            ],
            backgroundColor: topAppBarColor,
            title: Text(
              textAlign: TextAlign.center,
              'Stumble!',
              style: GoogleFonts.sacramento(
                fontSize: MediaQuery.of(context).size.width / 12,
                color: headingColor,
                fontWeight: FontWeight.w900,
              ),
            )),
      ),
      body: Stack(
        alignment: AlignmentDirectional.topCenter,
        children: [
          const BackgroundCurveWidget(),
          CardsStackWidget(),
          const MyLocationComponent(),
        ],
      ),
      bottomNavigationBar:
          const BottomBar(currentScreen: BottomBarScreens.swipingScreen),
    );
  }
}
