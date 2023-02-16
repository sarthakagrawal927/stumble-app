import 'package:flutter/material.dart';

import 'first_name_screen.dart';
import '../../widgets/newUser/screen_heading_widget.dart';
import '../../widgets/newUser/button_to_accept_or_reject.dart';

class TermsAndConditionsScreen extends StatelessWidget {
  const TermsAndConditionsScreen({super.key});
  static const routeName = '/terms-and-conditions-screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(26, 28, 29, 1),
      body: Padding(
        padding: EdgeInsets.symmetric(
          vertical: MediaQuery.of(context).size.height / 16,
          horizontal: MediaQuery.of(context).size.width / 16,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: MediaQuery.of(context).size.height / 32,
                horizontal: MediaQuery.of(context).size.width / 16,
              ),
              child:
                  Icon(Icons.lock, size: MediaQuery.of(context).size.width / 3),
            ),
            ScreenHeadingWidget("We care about your privacy!"),
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: MediaQuery.of(context).size.height / 32,
                horizontal: MediaQuery.of(context).size.width / 16,
              ),
              child: const Text(
                  style: TextStyle(
                      fontSize: 25, color: Color.fromRGBO(237, 237, 237, 1)),
                  "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore "),
            ),
            ButtonToAcceptOrRejectConditions("Accept",
                Color.fromRGBO(116, 91, 53, 1), FirstNameScreen.routeName),
            ButtonToAcceptOrRejectConditions(
                "Reject", Color.fromRGBO(57, 66, 70, 1), ""),
          ],
        ),
      ),
    );
  }
}
