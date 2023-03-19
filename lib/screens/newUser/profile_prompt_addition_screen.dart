import 'package:flutter/material.dart';

import '../swiping_screen.dart';
import '../../widgets/newUser/screen_heading_widget.dart';

class ProfilePromptAdditionScreen extends StatelessWidget {
  const ProfilePromptAdditionScreen({super.key});
  static const routeName = '/profile-prompt-addition-screen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(26, 28, 29, 1),
      body: Padding(
        padding: EdgeInsets.symmetric(
          vertical: MediaQuery.of(context).size.height / 16,
          horizontal: MediaQuery.of(context).size.width / 16,
        ),
        child: ListView(
          children: [
            const ScreenHeadingWidget(
                "Tell people somethings that you're interested in!"),
            SizedBox(
              height: MediaQuery.of(context).size.height / 7,
            ),
            SingleChildScrollView(
              child: TextFormField(
                style: const TextStyle(
                  color: Color.fromRGBO(237, 237, 237, 1),
                  fontSize: 20,
                ),
                initialValue: '',
                maxLines: 3,
                minLines: 1,
                keyboardAppearance: Brightness.dark,
                textInputAction: TextInputAction.next,
                cursorColor: const Color.fromRGBO(237, 237, 237, 1),
                onFieldSubmitted: (_) => {
                  Navigator.of(context)
                      .pushReplacementNamed(SwipingScreen.routeName),
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
