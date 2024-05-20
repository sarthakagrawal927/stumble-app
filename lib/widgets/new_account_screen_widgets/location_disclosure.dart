
import 'package:dating_made_better/screens/login_or_signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../constants.dart';
import '../../providers/profile.dart';
import '../../screens/swiping_screen.dart';
import '../newUser/screen_heading_widget.dart';
import '../newUser/screen_go_to_next_page_row.dart';

// ignore: must_be_immutable
class LocationDisclosure extends StatefulWidget {
  Size deviceSize;
  LocationDisclosure(this.deviceSize, {super.key});

  @override
  State<LocationDisclosure> createState() => _LocationDisclosureState();
}

class _LocationDisclosureState extends State<LocationDisclosure> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const ScreenHeadingWidget("How is your location used for stumbling?"),
        SizedBox(
          height: MediaQuery.of(context).size.height / 12,
        ),
        SingleChildScrollView(
          child: Container(
            color: const Color.fromRGBO(35, 16, 51, 1),
            margin: EdgeInsets.only(
              left: marginWidth16(context),
              right: marginWidth16(context),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: marginWidth128(context), 
                vertical: marginHeight128(context),
              ),
              child: Text("Stumble collects location data to show your profile to other potential stumblers in your immediate vicinity, even when the app is closed or not in use.", 
              style: TextStyle(
                      fontSize: marginWidth16(context),
                      color: whiteColor,
                      ),
              ),
            ),
          ),
        ),
        ScreenGoToNextPageRow(
          "Click this to begin stumbling!",
          "",
          () async {
              if (isLoading) return;
              isLoading = true;
              try {
                Provider.of<Profile>(context, listen: false)
                    .upsertUserOnboarding()
                    .then((value) {
Navigator.of(context).pushNamed(SwipingScreen.routeName);
                });
              } catch (e) {
                // redirect to login screen
Navigator.of(context).pushNamed(AuthScreen.routeName);
              } finally {
                isLoading = false;
              }
            }, 
        ),
      ],
    );
  }
}
