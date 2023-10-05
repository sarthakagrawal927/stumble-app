import 'package:dating_made_better/global_store.dart';
import 'package:dating_made_better/screens/swiping_screen.dart';
import 'package:dating_made_better/utils/call_api.dart';
import 'package:dating_made_better/utils/helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../providers/first_screen_state_providers.dart';
import '../../providers/profile.dart';

// ignore: must_be_immutable
class OTPScreenColumn extends StatefulWidget {
  Size deviceSize;
  OTPScreenColumn(this.deviceSize, {super.key});

  @override
  State<OTPScreenColumn> createState() => _OTPScreenColumnState();
}

class _OTPScreenColumnState extends State<OTPScreenColumn> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Flexible(
          child: Container(
            margin: EdgeInsets.only(top: widget.deviceSize.height / 8),
            child: Text(
              'Stumble',
              style: GoogleFonts.sacramento(
                fontSize: 60.0,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        SizedBox(
          height: widget.deviceSize.height / 4,
        ),
        OtpTextField(
          numberOfFields: 6,
          borderColor: const Color(0xFF512DA8),
          //set to true to show as box or false to show as dash
          showFieldAsBox: true,
          //runs when a code is typed in
          onCodeChanged: (String code) {
            //handle validation or checks here
          },
          //runs when every textfield is filled
          onSubmit: (String verificationCode) async {
            ScreenMode screenMode;
            verifyOtpApi(verificationCode,
                    Provider.of<Profile>(context, listen: false).getPhone)
                .then((profile) {
              screenMode = getScreenMode();
              if (AppConstants.token.isNotEmpty) {
                Provider.of<FirstScreenStateProviders>(context, listen: false)
                    .setActiveScreenMode(screenMode);
                if (screenMode == ScreenMode.swipingScreen) {
                  // redirect to swiping screen
                  Navigator.of(context)
                      .pushReplacementNamed(SwipingScreen.routeName);
                }
              }
            });
          }, // end onSubmit
        ),
      ],
    );
  }
}
