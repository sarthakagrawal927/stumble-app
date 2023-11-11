import 'package:dating_made_better/providers/first_screen_state_providers.dart';
import 'package:flutter/gestures.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class FirstScreenColumn extends StatefulWidget {
  Size deviceSize;

  FirstScreenColumn(this.deviceSize, {super.key});

  @override
  State<FirstScreenColumn> createState() => _FirstScreenColumnState();
}

class _FirstScreenColumnState extends State<FirstScreenColumn> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
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
        Flexible(
          child: Container(
            margin: EdgeInsets.only(
              top: widget.deviceSize.height / 32,
            ),
            child: Text(
              'into someone amazing!',
              style: GoogleFonts.sacramento(
                fontSize: 30.0,
                color: Colors.white,
              ),
              textAlign: TextAlign.end,
            ),
          ),
        ),
        SizedBox(
          height: widget.deviceSize.height / 8,
        ),
        ElevatedButton(
          onPressed: () {
            Provider.of<FirstScreenStateProviders>(context, listen: false)
                .setNextScreenActive();
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            minimumSize: Size(
                widget.deviceSize.width / 2, widget.deviceSize.height / 16),
          ),
          child: const Text(
            "Use mobile number",
            style: TextStyle(fontSize: 20),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(
            vertical: widget.deviceSize.height / 16,
            horizontal: widget.deviceSize.width / 16,
          ),
          child: RichText(
            text: TextSpan(
              children: [
                const TextSpan(
                  text: "By signing up, you agree to our ",
                  style: TextStyle(fontSize: 15, color: Colors.white),
                ),
                TextSpan(
                  text: 'Terms',
                  style: const TextStyle(fontSize: 15, color: Colors.blue),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      launchUrl(
                          Uri.parse('https://www.getstumble.app/privacy'));
                    },
                ),
                const TextSpan(
                  text:
                      ". See how we use your data in our Privacy policy. We never post to facebook.",
                  style: TextStyle(fontSize: 15, color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
