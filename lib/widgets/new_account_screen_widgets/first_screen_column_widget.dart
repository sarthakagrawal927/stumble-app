import 'dart:async';
import 'dart:io';

import 'package:dating_made_better/constants.dart';
import 'package:dating_made_better/constants_colors.dart';
import 'package:dating_made_better/constants_fonts.dart';
import 'package:dating_made_better/hooks/index.dart';
import 'package:dating_made_better/utils/call_api.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:url_launcher/url_launcher.dart';

// ignore: must_be_immutable
class FirstScreenColumn extends StatefulWidget {
  Size deviceSize;

  FirstScreenColumn(this.deviceSize, {super.key});

  @override
  State<FirstScreenColumn> createState() => _FirstScreenColumnState();
}

class _FirstScreenColumnState extends State<FirstScreenColumn>
    with TickerProviderStateMixin {
  late AnimationController _stumbleAnimationController;
  late AnimationController _mottoAnimationController;
  late AnimationController _otherWidgetsAnimationController;

  late Animation<double> _stumbleTextAnimation;
  late Animation<double> _mottoTextAnimation;
  late Animation<double> _otherWidgetsAnimation;

  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: ['email'],
  );

  Future<void> _handleSignIn() async {
    try {
      // check platform use apple for ios
      if (Platform.isAndroid) {
        await _googleSignIn.signIn();
      } else if (Platform.isIOS) {
        final credential = await SignInWithApple.getAppleIDCredential(
          scopes: [AppleIDAuthorizationScopes.email],
        );

        verifyAppleAuth(credential)
            .then((value) => handleSignInComplete(context));
      }
    } catch (error) {
      debugPrint(error.toString());
    }
  }

  @override
  void dispose() {
    _stumbleAnimationController.dispose();
    _mottoAnimationController.dispose();
    _otherWidgetsAnimationController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _stumbleAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );
    _mottoAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    _otherWidgetsAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );
    _stumbleTextAnimation = CurvedAnimation(
      parent: _stumbleAnimationController,
      curve: Curves.easeIn,
    );
    _mottoTextAnimation = CurvedAnimation(
      parent: _mottoAnimationController,
      curve: Curves.easeIn,
    );
    _otherWidgetsAnimation = CurvedAnimation(
      parent: _otherWidgetsAnimationController,
      curve: Curves.easeIn,
    );

    _googleSignIn.onCurrentUserChanged
        .listen((GoogleSignInAccount? account) async {
      if (account != null) {
        await verifyGoogleAuth(account).then((profile) {
          handleSignInComplete(context);
        });
      }
    });
    Future.delayed(const Duration(seconds: 3), () {
      _mottoAnimationController.forward();
    });
    Future.delayed(const Duration(seconds: 7), () {
      _otherWidgetsAnimationController.forward();
    });
    _stumbleAnimationController.forward();
    // _googleSignIn.signInSilently();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Flexible(
          child: FadeTransition(
            opacity: _stumbleTextAnimation,
            child: Text(
              'Stumble',
              style: GoogleFonts.sacramento(
                fontSize: fontSize16(context),
                color: whiteColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        Flexible(
          child: Container(
            margin: EdgeInsets.only(
              top: widget.deviceSize.height / 32,
            ),
            child: FadeTransition(
              opacity: _mottoTextAnimation,
              child: Text(
                'into someone amazing!',
                style: GoogleFonts.sacramento(
                  fontSize: fontSize24(context),
                  color: whiteColor,
                ),
                textAlign: TextAlign.end,
              ),
            ),
          ),
        ),
        SizedBox(
          height: widget.deviceSize.height / 8,
        ),
        FadeTransition(
          opacity: _otherWidgetsAnimation,
          child: ElevatedButton(
            onPressed: () async {
              await _handleSignIn();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: whiteColor,
              minimumSize: Size(
                  widget.deviceSize.width / 2, widget.deviceSize.height / 16),
            ),
            child: Text(
              "Sign in with ${Platform.isAndroid ? 'Google' : 'Apple'}",
              style: TextStyle(
                  fontSize: fontSize48(context),
                  color: filterScreenHeadingColor),
            ),
          ),
        ),
        FadeTransition(
          opacity: _otherWidgetsAnimation,
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: widget.deviceSize.height / 16,
              horizontal: widget.deviceSize.width / 16,
            ),
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: "By signing up, you agree to our ",
                    style: TextStyle(
                        fontSize: fontSize64(context), color: whiteColor),
                  ),
                  TextSpan(
                    text: 'Terms',
                    style: TextStyle(
                        fontSize: fontSize64(context), color: blueColor),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        launchUrl(Uri.parse(privacyUrl));
                      },
                  ),
                  TextSpan(
                    text:
                        ". See how we use your data in our Privacy policy. We never post to facebook.",
                    style: TextStyle(
                        fontSize: fontSize64(context), color: whiteColor),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
