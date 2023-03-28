import 'package:dating_made_better/widgets/newUser/screen_go_to_next_page_row.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../swiping_screen.dart';
import '../../providers/profile.dart';
import '../../widgets/newUser/screen_heading_widget.dart';

class ProfilePromptAdditionScreen extends StatefulWidget {
  const ProfilePromptAdditionScreen({super.key});
  static const routeName = '/profile-prompt-addition-screen';

  @override
  State<ProfilePromptAdditionScreen> createState() =>
      _ProfilePromptAdditionScreenState();
}

class _ProfilePromptAdditionScreenState
    extends State<ProfilePromptAdditionScreen> {
  String promptTextValue = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(26, 28, 29, 1),
      body: Padding(
        padding: EdgeInsets.symmetric(
          vertical: MediaQuery.of(context).size.height / 16,
          horizontal: MediaQuery.of(context).size.width / 16,
        ),
        child: Column(
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
                onFieldSubmitted: (value) => {
                  setState(() {
                    promptTextValue = value;
                  }),
                },
              ),
            ),
            ScreenGoToNextPageRow(
              "This will be shown on your profile!",
              SwipingScreen.routeName,
              () {
                Provider.of<Profile>(context, listen: false).setProfilePrompt =
                    promptTextValue;
              },
            ),
          ],
        ),
      ),
    );
  }
}
