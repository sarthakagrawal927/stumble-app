import 'package:dating_made_better/hooks/index.dart';
import 'package:dating_made_better/utils/call_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

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
          textStyle: const TextStyle(
            color: Colors.white,
          ),
          numberOfFields: 6,
          fillColor: Colors.white,
          borderColor: const Color(0xFF512DA8),
          //set to true to show as box or false to show as dash
          showFieldAsBox: true,
          //runs when a code is typed in
          onCodeChanged: (String code) {
            //handle validation or checks here
          },
          //runs when every textfield is filled
          onSubmit: (String verificationCode) async {
            final profile = Provider.of<Profile>(context, listen: false);
            await verifyOtpApi(verificationCode, profile.getPhone);
            if (!mounted) return; // Check if the widget is still mounted
            handleSignInComplete(context);
          }, // end onSubmit
        ),
      ],
    );
  }
}
