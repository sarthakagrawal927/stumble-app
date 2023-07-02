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
            bool isOTPCorrect =
                await Provider.of<Profile>(context, listen: false)
                    .verifyOTPAPI(verificationCode);

            setState(() {
              if (isOTPCorrect) {
                Provider.of<FirstScreenStateProviders>(context, listen: false)
                    .setisOTPSubmittedValue = true;
              }
            });
          }, // end onSubmit
        ),
      ],
    );
  }
}
